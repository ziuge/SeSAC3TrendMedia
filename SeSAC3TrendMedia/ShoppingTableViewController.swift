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
    
    var lists: Results<UserShoppingList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lists = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "date", ascending: true)
        
        textBannerView.layer.cornerRadius = 10
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lists = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "date", ascending: true)
        tableView.reloadData()
    }

    
    @objc func addItem() {
        print("additem")
        let list = UserShoppingList(name: "item\(Int.random(in: 1...1000))", date: Date(), check: "", favorite: "")
        
        try! localRealm.write {
            localRealm.add(list)
            print("realm success")
        }
    }

    @IBAction func userTextFieldFinished(_ sender: UITextField) {
        shoppingList.append(userTextField.text!)
        
        tableView.reloadData()
        userTextField.text = ""
    }
    
    @IBAction func userBtnTapped(_ sender: UIButton) {
        if userTextField.text != nil {
            shoppingList.append(userTextField.text!)
        }
        
        addItem()
        
        tableView.reloadData()
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
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            lists.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }

}
