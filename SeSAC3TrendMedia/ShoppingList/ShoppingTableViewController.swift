//
//  ShoppingTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit
import RealmSwift
import Zip

class ShoppingTableViewController: UITableViewController, UIDocumentPickerDelegate {
    
    let localRealm = try! Realm()
    
    @IBOutlet weak var textBannerView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    var lists: Results<UserShoppingList>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortButton.title = "정렬"
        
        lists = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "date", ascending: true)
        
        textBannerView.layer.cornerRadius = 10
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        let recoveryButton = UIBarButtonItem(title: "복구", style: .plain, target: self, action: #selector(recoveryButtonClicked))
        navigationItem.rightBarButtonItems = [recoveryButton, backupButton]
    }
    
    // 백업
    @objc func backupButtonClicked() {
        print(#function)
        var urlPaths = [URL]()
        
        // 도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlert(alertTitle: "백업할 파일이 없습니다")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        // 백업 파일을 압축 : URL
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSACShoppingList_1")
            print("Archive location: \(zipFilePath)")
            showActivityViewController()
        } catch {
            showAlert(alertTitle: "압축에 실패했습니다", alertMessage: "")
        }
        
    }
    
    func showActivityViewController() {
        print(#function)
        // 도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "도큐먼트 위치에 오류가 있습니다", alertMessage: "")
            return
        }
        let backupFileURL = path.appendingPathComponent("SeSACShoppingList_1.zip")
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func recoveryButtonClicked() {
        print(#function)
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }

    func fetchRealm() {
        lists = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    @objc func addItem(name: String) {
        print("additem")
        let list = UserShoppingList(name: name, date: Date(), check: false, favorite: false, photo: "")
        
        try! localRealm.write {
            localRealm.add(list)
            print("realm success")
        }
    }

    @IBAction func userTextFieldFinished(_ sender: UITextField) {
        guard let name = userTextField.text else { return }
        addItem(name: name)
        
        userTextField.text = ""
    }
    
    @IBAction func userBtnTapped(_ sender: UIButton) {
        guard let name = userTextField.text else { return }
        addItem(name: name)
        fetchRealm()
        userTextField.text = ""
        userTextField.endEditing(true)
    }
    
    @IBAction func sortBtnTapped(_ sender: UIBarButtonItem) {
        print("== sort")
        showAlertController(style: .actionSheet)
    }
    
    func showAlertController(style: UIAlertController.Style) {
        let alertController: UIAlertController
        alertController = UIAlertController(title: "정렬", message: "message", preferredStyle: style)
        
        let name = UIAlertAction(title: "제목으로 정렬", style: .default) { UIAlertAction in
            self.lists = self.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "name", ascending: true)
        }
        let date = UIAlertAction(title: "날짜로 정렬", style: .default) { UIAlertAction in
            self.lists = self.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "date", ascending: true)
        }
        let check = UIAlertAction(title: "체크로 정렬", style: .default) { UIAlertAction in
            self.lists = self.localRealm.objects(UserShoppingList.self).filter("check == false")
//            self.lists = self.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "check", ascending: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(name)
        alertController.addAction(date)
        alertController.addAction(check)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true)
        
    }
    
    func detailClicked(indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.list = lists[indexPath.row]
        vc.mainView.titleTextField.text = lists[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
    }
    

// MARK: - TableView Delegate, DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.checkLabel.text = lists[indexPath.row].name
        cell.checkLabel.font = .boldSystemFont(ofSize: 12)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailClicked(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in

            // realm data update
            try! self.localRealm.write {
                // 하나의 레코드에서 특정 컬럼 하나만 변경
                self.lists[indexPath.row].favorite = !self.lists[indexPath.row].favorite
            }
            self.fetchRealm()
        }
        
        let image = lists[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemYellow
        
        let pickImage = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("pickImage")
            let vc = ImagePickViewController()
            self.present(vc, animated: true)
        }
        pickImage.image = UIImage(systemName: "camera.fill")
        
        return UISwipeActionsConfiguration(actions: [favorite, pickImage])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("delete button clicked")
            
            try! self.localRealm.write {
                self.lists.realm?.delete(self.lists[indexPath.row])
            }
            self.fetchRealm()
        }
        
        let edit = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("edit button clicked")
            
            try! self.localRealm.write {
                self.lists[indexPath.row].name = "edited"
            }
            self.fetchRealm()
        }
        delete.image = UIImage(systemName: "trash")
        edit.image = UIImage(systemName: "pencil")

        return UISwipeActionsConfiguration(actions: [edit, delete])
    }


// MARK: - UIDocumentPickerDelegate
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        guard let selectedFileURL = urls.first else {
            showAlert(alertTitle: "선택하신 파일을 찾을 수 없습니다")
            return
        }
        guard let path = documentDirectoryPath() else {
            showAlert(alertTitle: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            let fileURL = path.appendingPathComponent("SeSACShoppingList_1.zip")

            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlert(alertTitle: "복구가 완료되었습니다")
                })
            } catch {
                showAlert(alertTitle: "압축 해제에 실패했습니다")
            }
        } else {
            do {
                // 파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let fileURL = path.appendingPathComponent("SeSACShoppingList_1.zip")
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlert(alertTitle: "복구가 완료되었습니다")
                })
            } catch {
                showAlert(alertTitle: "압축 해제에 실패했습니다")
            }
        }
    }
}
