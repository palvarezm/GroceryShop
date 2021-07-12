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
    
    init() { }
}

extension TabBarPresenter: TabBarPresenterProtocol {
    func viewDidLoad() {
        
    }
}
