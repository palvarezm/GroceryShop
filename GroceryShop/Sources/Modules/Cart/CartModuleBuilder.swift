//
//  CartModuleBuilder.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 25/07/21.
//

import UIKit

class CartModuleBuilder {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Cart", bundle: nil)
    }
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: CartViewController.self))
        return factory(viewController)
    }
}
