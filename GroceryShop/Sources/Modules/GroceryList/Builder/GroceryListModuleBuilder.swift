//
//  GroceryListModuleBuilder.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import UIKit

class GroceryListModuleBuilder {
    static var storyboard: UIStoryboard{
        return UIStoryboard(name: "GroceryList", bundle: nil)
    }
    
    static func build(usingCategory category: CategoryItemViewModel) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: GroceryListViewController.self)) as! GroceryListViewController
        let localDataManager: GroceryListLocalDataManagerInputProtocol = GroceryListLocalDataManager()
        let remoteDataManager: GroceryListRemoteDataManagerInputProtocol = GroceryListRemoteDataManager()
        let groceryListInteractor = GroceryListInteractor()
        groceryListInteractor.remoteDataManager = remoteDataManager
        groceryListInteractor.localDataManager = localDataManager
        remoteDataManager.remoteRequestHandler = groceryListInteractor
        
        let imageRemoteDataManager = ImageRemoteDataManager()
        let imageInteractor = ImageInteractor(service: imageRemoteDataManager)
        
        let cartLocalDataManager: CartLocalDataManagerProtocol = CartLocalDataManager()
        let cartInteractor = CartInteractor(localDataManager: cartLocalDataManager)
        let router = GroceryListRouter(viewController: viewController)
                
        let presenter = GroceryListPresenter(view: viewController, interactor: groceryListInteractor, imageInteractor: imageInteractor, cartInteractor: cartInteractor, router: router, category: category)
        
        groceryListInteractor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
