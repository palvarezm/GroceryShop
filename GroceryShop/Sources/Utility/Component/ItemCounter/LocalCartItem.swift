//
//  LocalCartItem.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 19/07/21.
//

import RealmSwift

class LocalCartItem: Object {
    @objc dynamic var skuId: String = ""
    @objc dynamic var value: Int = 0
    @objc dynamic var updated: Date = Date()
    
    override static func primaryKey() -> String? {
        return "skuId"
    }
}

extension LocalCartItem {
    convenience init(cartItem: CartItem) {
        self.init()
        self.skuId = cartItem.skuId
        self.value = cartItem.value
    }
}
