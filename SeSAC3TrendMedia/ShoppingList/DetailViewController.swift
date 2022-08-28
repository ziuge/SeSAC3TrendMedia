//
//  DetailViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/26.
//

import UIKit
import RealmSwift

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

class DetailViewController: BaseViewController {
    
    let repository = UserShoppingListRepository()
    
    let mainView = DetailView()
    let localRealm = try! Realm()
    
    var lists: Results<UserShoppingList>!
    var list: UserShoppingList!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func saveButtonClicked() {
        guard let title = mainView.titleTextField.text else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
//        repository.addItem(item: UserShoppingList(name: title, date: Date(), check: false, favorite: false))
        repository.updateTitle(item: list, title: title)
        dismiss(animated: true)
    }
}

extension DetailViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        mainView.imageView.image = image
        print(#function)
    }
}
