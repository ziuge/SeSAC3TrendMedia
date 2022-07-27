//
//  BucketListTableViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketListTableViewController: UITableViewController {
    
    static let identifier = "BucketListTableViewController"
    
    // 한 번만 실행되는 이유? UI적 요소는 거의 클래스로.
    // 클래스는 ReferenceType -> 인스턴스 자체를 변경하지 않는 이상 한 번만 실행됨!
    // IBOutlet ViewDidLoad 호출 되기 직전에 nil 여부를 알 수 있음
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 18)
            userTextField.textColor = .systemMint
            print("텍스트필드 didSet")
        }
    }
    
    // list 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰를 항상 갱신하기
//    var list = ["범죄도시2", "탑건", "토르", "헤어질 결심", "커피프린스 1호점", "내 이름은 김삼순", "궁", "울랄라", "고릴라", "우락부락", "탑건2"]
    var list = [Todo(title: "범죄도시2", done: false), Todo(title: "탑건", done: false)] {
        didSet {
            tableView.reloadData()
            print("리스트 변경됨! \(list), \(oldValue)")
        }
    }
    
    var placeholder: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeBtnClicked)) // style: .plain, target: self <- 이부분은 거의 달라지지 않음

        tableView.rowHeight = 80
        
        userTextField.placeholder = "\(placeholder ?? "영화")를 검색해주세요"
         
//        list.append("마녀")
//        list.append("aaa")
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
//        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) else { // 공백 지우기
//            // Alert, Toast를 통해 알려주기 (빈칸을 입력했다, 글자 수가 많다 등)
//            return
//        }
//        list.append(value)
//        tableView.reloadData()
        
        
        // Case 1. 옵셔널 강제 해제
//        list.append(userTextField.text!)
//        tableView.reloadData() // 테이블 뷰 다시 그려줘
//        tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableView.RowAnimation#>)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        list.append(Todo(title: sender.text!, done: false))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as! BucketListTableViewCell // as? 타입 캐스팅
        // identifier 일일이 쓰기 귀찮음 -> 어차피 같은 것을 계속 쓰니까 타입 프로퍼티로 선언
        
        cell.bucketListLabel.text = list[indexPath.row].title
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.checkBoxBtn.tag = indexPath.row
        cell.checkBoxBtn.addTarget(self, action: #selector(checkBoxBtnClicked(sender:)), for: .touchUpInside)
        
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkBoxBtn.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
    }
    
    @objc func checkBoxBtnClicked(sender: UIButton) {
        print("\(sender.tag)번째 버튼 클릭!")
        
        // 배열 인덱스를 찾아서 done을 바꿔야 한다! 그리고 테이블 뷰 갱신 해야한다!
        list[sender.tag].done = !list[sender.tag].done

        // tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)

        // 재사용 셀 오류 확인용 코드
//        sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // 배열 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
//            tableView.reloadData()
        }
    }
}

