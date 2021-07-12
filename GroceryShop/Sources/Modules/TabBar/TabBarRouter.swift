//
//  TabBarRouter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import UIKit

class TabBarRouter {
    var view: UIViewController
    
    typealias Submodules = (
        home: UIViewController,
        cart: UIViewController,
        profile: UIViewController
    )
    
    init(view:UIViewController) {
        self.view = view
    }
}

extension TabBarRouter {
    static func tabs(usingSubmodules submodules: Submodules) -> GroceryTabs {
        let homeTabBarItem = UITabBarItem(title: "home_tab_bar_item".localized, image: UIImage(systemName: "house.fill"), tag: 11)
        let cartTabBarItem = UITabBarItem(title: "cart_tab_bar_item".localized, image: UIImage(systemName: "cart.fill"), tag: 12)
        let profileTabBarItem = UITabBarItem(title: "profile_tab_bar_item".localized, image: UIImage(systemName: "person.crop.circle.fill"), tag: 13)
        
        submodules.home.tabBarItem = homeTabBarItem
        submodules.cart.tabBarItem = cartTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        
        return (
            home: submodules.home,
            cart: submodules.cart,
            profile: submodules.profile
        )
    }
}
