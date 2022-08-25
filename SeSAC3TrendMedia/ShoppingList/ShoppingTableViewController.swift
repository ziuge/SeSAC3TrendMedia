//
//  ShoppingTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit
import RealmSwift

class ShoppingTableViewController: UITableViewController {
    
    let localRealm = try! Realm()
    
    var shoppingList: [String] = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 알아보기", "양말"]
    
    @IBOutlet weak var textBannerView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userBtn: UIButton!
    
    var lists: Results<UserShoppingList>! {
        didSet {
            tableView.reloadData()
            print("reload success")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lists = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "date", ascending: true)
        
        textBannerView.layer.cornerRadius = 10
        
//        print("Realm is located at:", localRealm.configuration.fileURL!)
        
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
        let list = UserShoppingList(name: name, date: Date(), check: false, favorite: false)
        
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
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.checkLabel.text = lists[indexPath.row].name
        cell.checkLabel.font = .boldSystemFont(ofSize: 12)
        
        return cell
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

}
