//
//  DetailViewController.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/26.
//

import UIKit
import RealmSwift
import SwiftUI

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
        mainView.imageView.image = loadImageFromDocument(fileName: "\(list.objectId).jpg")
        
        let imageButton = UIBarButtonItem(image: UIImage(systemName: "camera.fill"), style: .plain, target: self, action: #selector(selectImageClicked))
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItems = [saveButton, imageButton]
    }
    
    @objc func selectImageClicked() {
        let vc = ImagePickViewController()
        vc.delegate = self
        transition(vc, transitionStyle: .presentFullScreenNavigation)
    }
    
    @objc func saveButtonClicked() {
        guard let title = mainView.titleTextField.text else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
        if let image = mainView.imageView.image {
            saveImageToDocument(fileName: "\(list.objectId).jpg", image: image)
        }
        let photo = String(describing: mainView.imageView.image)
        repository.updateItem(item: list, title: title, photo: photo)
        dismiss(animated: true)
    }
}

extension DetailViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        mainView.imageView.image = image
        print(#function)
    }
}
