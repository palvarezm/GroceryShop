//
//  CategoryListModuleBuilder.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import UIKit

class CategoryListModuleBuilder {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "CategoryList", bundle: nil)
    }
    
    static func build(usingNavigationFactory navigationFactory: NavigationFactory) -> UINavigationController {
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: CategoryListViewController.self)) as! CategoryListViewController
        
        let localDataManager: CategoryListLocalDataManagerInputProtocol = CategoryListLocalDataManager()
        let remoteDataManager: CategoryListRemoteDataManagerInputProtocol = CategoryListRemoteDataManager()
        let categoryListInteractor = CategoryListInteractor()
        categoryListInteractor.localDataManager = localDataManager
        categoryListInteractor.remoteDataManager = remoteDataManager
        remoteDataManager.remoteRequestHandler = categoryListInteractor
        
        let router = CategoryListRouter(viewController: viewController)
        let presenter = CategoryListPresenter(view: viewController, router: router, interactor: categoryListInteractor)
        
        categoryListInteractor.presenter = presenter
        viewController.presenter = presenter
        return navigationFactory(viewController)
    }
}
