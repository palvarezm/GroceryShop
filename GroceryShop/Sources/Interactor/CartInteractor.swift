//
//  CartInteractor.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 22/07/21.
//

protocol CartInteractorProtocol {
    var localDataManager: CartLocalDataManagerProtocol { get set }
    
    func getCartItem(skuId: String) -> (CartItem)
    func getCartCount(closure: @escaping CartCountClosure) -> (Void)
    func addToCart(cartItem: CartItem) -> (Void)
}

class CartInteractor {
    var localDataManager: CartLocalDataManagerProtocol
    
    init(localDataManager: CartLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
}

extension CartInteractor: CartInteractorProtocol {
    func getCartItem(skuId: String) -> (CartItem) {
        self.localDataManager.getCartItem(usingSkuId: skuId)
    }
    
    func getCartCount(closure: @escaping CartCountClosure) {
        self.localDataManager.getCount(closure: closure)
    }
    
    func addToCart(cartItem: CartItem) {
        if (cartItem.value > 0) {
            self.localDataManager.updateCart(usingCartItem: cartItem)
        }
        else {
            self.localDataManager.deleteItem(usingCartItem: cartItem)
        }
    }
}
