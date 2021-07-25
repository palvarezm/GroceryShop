//
//  CartItem.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 19/07/21.
//

struct CartItem {
    let skuId: String
    let value: Int
    
    init(skuId: String, value: Int) {
        self.skuId = skuId
        self.value = value
    }
}

extension CartItem {
    init(localCartItem: LocalCartItem) {
        self.skuId = localCartItem.skuId
        self.value = localCartItem.value
    }
}
