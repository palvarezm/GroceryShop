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
    func navigateToCategoryGroceries(usingCategory category: CategoryItemViewModel) {
        let groceryListViewController =
            GroceryListModuleBuilder.build(usingCategory: category)
        viewController.navigationController?.pushViewController(groceryListViewController, animated: true)
    }
}
