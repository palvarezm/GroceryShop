//
//  CartLocalDataManager.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 22/07/21.
//

import RealmSwift

class CartLocalDataManager {
    static let shared: CartLocalDataManager = CartLocalDataManager()
    var notificationToken: NotificationToken?
    
    init() { }
    
    deinit {
        notificationToken?.invalidate()
    }
}

extension CartLocalDataManager: CartLocalDataManagerProtocol {
    func getCartItem(usingSkuId skuId: String) -> CartItem {
        let realm = try! Realm()
        guard let localCartItem = realm.objects(LocalCartItem.self).first(where: { $0.skuId == skuId })
        else {
            return CartItem(skuId: skuId, value: 0)
        }
        return CartItem(localCartItem: localCartItem)
    }
    
    func getCount(closure: @escaping CartCountClosure) {
        let realm = try! Realm()
        let localCartItem = realm.objects(LocalCartItem.self)
        notificationToken = localCartItem.observe({ _ in
            closure(localCartItem.count)
        })
    }
    
    func updateCart(usingCartItem cartItem: CartItem) {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(LocalCartItem(cartItem: cartItem), update: .all)
            }
        }
        catch {
            debugPrint("Something went wrong with REALM DB: \(error)")
        }
    }
    
    func deleteItem(usingCartItem cartItem: CartItem) {
        do {
            let realm = try! Realm()
            try realm.write {
                if let localCartItem = realm.objects(LocalCartItem.self).first(where: { $0.skuId == cartItem.skuId}) {
                    realm.delete(localCartItem)
                }
            }
        }
        catch {
            debugPrint("Something went wrong with REALM DB: \(error)")
        }
    }
}

