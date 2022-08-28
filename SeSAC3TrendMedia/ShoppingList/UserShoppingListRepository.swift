//
//  UserShoppingListRepository.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/28.
//

import Foundation
import RealmSwift

protocol UserDiaryRepositoryType {
    func updateTitle(item: UserShoppingList, title: String)
}

class UserShoppingListRepository {
    let localRealm = try! Realm()
    
    func addItem(item: UserShoppingList) {
        try! localRealm.write({
            localRealm.add(item)
        })
    }
    
    func updateTitle(item: UserShoppingList, title: String) {
        try! localRealm.write({
            item.name = title
        })
    }
}
