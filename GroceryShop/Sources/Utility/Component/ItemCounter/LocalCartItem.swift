//
//  LocalCartItem.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 19/07/21.
//

import RealmSwift

class LocalCartItem: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var value: Int = 0
    @objc dynamic var updated: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension LocalCartItem {
    convenience init(cartItem: CartItem) {
        self.init()
        self.id = cartItem.id
        self.value = cartItem.value
    }
}
