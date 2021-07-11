//
//  NavigationBuilder.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 10/07/21.
//

import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class NavigationBuilder {
    static func build(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
}
