//
//  TabBarController.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import UIKit

protocol TabBarControllerProtocol: class {
    
}

class TabBarController: UITabBarController {
    var cartTab: UIViewController
    var presenter: TabBarPresenterProtocol?
    
    init(tabs: GroceryTabs, presenter: TabBarPresenterProtocol) {
        self.cartTab = tabs.cart
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [tabs.home, cartTab, tabs.profile]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension TabBarController: TabBarControllerProtocol {
    
}
