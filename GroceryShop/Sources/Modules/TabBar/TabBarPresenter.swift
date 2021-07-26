//
//  TabBarPresenter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

protocol TabBarPresenterProtocol {
    func viewDidLoad() -> Void
}

class TabBarPresenter {
    weak var view: TabBarControllerProtocol?
    var cartInteractor: CartInteractorProtocol?
    
    init(cartInteractor: CartInteractorProtocol) {
        self.cartInteractor = cartInteractor
    }
}

extension TabBarPresenter: TabBarPresenterProtocol {
    func viewDidLoad() {
        self.cartInteractor?.getCartCount { count in
            self.view?.updateCartCount(count: count)
        }
    }
}
