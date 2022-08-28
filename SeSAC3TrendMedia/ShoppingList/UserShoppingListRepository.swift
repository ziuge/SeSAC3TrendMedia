//
//  UserShoppingListRepository.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/28.
//

import Foundation
import RealmSwift

protocol UserDiaryRepositoryType {
    func updateItem(item: UserShoppingList, title: String, photo: String)
}

class UserShoppingListRepository {
    let localRealm = try! Realm()
    
    func addItem(item: UserShoppingList) {
        try! localRealm.write({
            localRealm.add(item)
        })
    }
    
    func updateItem(item: UserShoppingList, title: String, photo: String) {
        try! localRealm.write({
            item.name = title
            item.photo = photo
        })
    }
}
