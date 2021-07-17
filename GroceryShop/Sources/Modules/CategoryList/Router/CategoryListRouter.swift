//
//  CategoryListRouter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import UIKit

class CategoryListRouter {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension CategoryListRouter: CategoryListRouterProtocol {
    
}
