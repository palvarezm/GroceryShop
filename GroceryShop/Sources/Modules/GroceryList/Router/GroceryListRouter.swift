//
//  GroceryListRouter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import UIKit

class GroceryListRouter {
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension GroceryListRouter: GroceryListRouterProtocol {
    
    func navigateBackToCategoryList() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
