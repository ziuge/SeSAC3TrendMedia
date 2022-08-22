//
//  RealmModel.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/08/22.
//

import Foundation
import RealmSwift

class UserShoppingList: Object {
    @Persisted var name: String // 이름 필수
    @Persisted var date: Date
    @Persisted var check: Bool // 체크 필수
    @Persisted var favorite: Bool // 즐겨찾기 필수
    
    // PK(필수): Int, String(부적합), UUID, ObjectID
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(name: String, date: Date, check: String, favorite: String) {
        self.init()
        self.name = name
        self.date = date
        self.check = false
        self.favorite = false
    }
    
}
