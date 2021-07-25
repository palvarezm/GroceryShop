//
//  CartLocalDataManagerProtocol.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 22/07/21.
//

typealias CartCountClosure = (Int) -> (Void)

protocol CartLocalDataManagerProtocol {
    func getCartItem(usingId id: String) -> CartItem
    func getCount(closure: @escaping CartCountClosure) -> Void
    func updateCart(usingCartItem cartItem: CartItem)
    func deleteItem(usingCartItem cartItem: CartItem)
}
