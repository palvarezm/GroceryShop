//
//  ItemCounterViewModel.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 19/07/21.
//

import Foundation

struct ItemCounterViewModel: Equatable {
    let id: String
    let title: String
    var counterValue: Int
    var showCounter: Bool
    
    init() {
        self.id = UUID.init().uuidString
        self.title = "add_product_to_cart_button".localized
        self.counterValue = 0
        self.showCounter = false
    }
    
    init(id: String, counterValue: Int) {
        self.id = id
        self.title = "add_product_to_cart_button".localized
        self.counterValue = counterValue
        self.showCounter = counterValue > 0
    }
}

extension ItemCounterViewModel {
    mutating func addToCart() {
        counterValue = 1
        showCounter = counterValue > 0
    }
    
    mutating func onIncrement() {
        counterValue += 1
        showCounter = counterValue > 0
    }
    
    mutating func onDecrement() {
        counterValue -= 1
        showCounter = counterValue > 0
    }
}
