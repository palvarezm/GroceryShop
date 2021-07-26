//
//  ProfileModuleBuilder.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 25/07/21.
//

import UIKit

class ProfileModuleBuilder {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: nil)
    }
    
    static func build(usingNavigationFactory factory: NavigationFactory) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ProfileViewController.self))
        return factory(viewController)
    }
}
