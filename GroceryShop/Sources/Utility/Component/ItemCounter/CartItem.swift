//
//  CartItem.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 19/07/21.
//

struct CartItem {
    let id: String
    let value: Int
    
    init(id: String, value: Int) {
        self.id = id
        self.value = value
    }
}

extension CartItem {
    init(localCartItem: LocalCartItem) {
        self.id = localCartItem.id
        self.value = localCartItem.value
    }
}
