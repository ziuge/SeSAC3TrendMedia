//
//  DetailViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/26.
//

import UIKit
import RealmSwift

class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    let localRealm = try! Realm()
    var index = 0
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(#function, self)
    }
    
    override func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked(item: lists[index])))
    }
    
    @objc func saveButtonClicked(item: UserShoppingList) {
        guard let title = mainView.titleTextField.text else {
            showAlertMessage(title: "내용을 입력해주세요", button: "확인")
            return
        }
        
        try! self.localRealm.write {
            item.name = "1"
        }
        
        dismiss(animated: true)
    }
    
    
}
