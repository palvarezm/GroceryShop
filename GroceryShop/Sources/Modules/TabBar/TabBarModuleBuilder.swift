//
//  TabBarModuleBuilder.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import UIKit

typealias GroceryTabs = (
    home: UIViewController,
    cart: UIViewController,
    profile: UIViewController
)

class TabBarModuleBuilder {
    static func build(usingSubmodules submodules: TabBarRouter.Submodules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubmodules: submodules)
        let presenter = TabBarPresenter()
        let tabBarController = TabBarController(tabs: tabs, presenter: presenter)
        presenter.view = tabBarController
        
        return tabBarController
    }
}
