//
//  BucketListTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    static var identifier = "BucketListTableViewController"
    
    @IBOutlet weak var userTextField: UITextField!
    var list = ["범죄도시2", "탑건", "토르"]
    
    var placeholder: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeBtnClicked)) // style: .plain, target: self <- 이부분은 거의 달라지지 않음

        tableView.rowHeight = 80
        
        userTextField.placeholder = "\(placeholder ?? "영화")를 검색해주세요"
         
        list.append("마녀")
        list.append("aaa")
    }
    
    @objc // obj-c 코드라는 것을 알려주기 위함
    func closeBtnClicked() {
        self.dismiss(animated: true)
    }
    
    @IBAction func userTextFieldFinished(_ sender: UITextField) {
        // Case 2. if let
//        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) { // 공백 지우기
//            list.append(value)
//            tableView.reloadData()
//        } else {
//            // 토스트 메시지 띄우기
//        }
        
        // Case 3. guard let
        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) else { // 공백 지우기
            // Alert, Toast를 통해 알려주기 (빈칸을 입력했다, 글자 수가 많다 등)
            return
        }
        list.append(value)
        tableView.reloadData()
        
        
        // Case 1. 옵셔널 강제 해제
//        list.append(userTextField.text!)
        // 테이블 뷰 다시 그려줘
//        tableView.reloadData()
//        tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableView.RowAnimation#>)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell // as? 타입 캐스팅
        // identifier 일일이 쓰기 귀찮음 -> 어차피 같은 것을 계속 쓰니까 타입 프로퍼티로 선언
        
        cell.bucketListLabel.text = list[indexPath.row]
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // 배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

