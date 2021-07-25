//
//  GroceryListProtocols.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import UIKit

protocol GroceryListViewProtocol: class {
    var presenter: GroceryListPresenterProtocol? { get set }
    
    func showGroceryList(groceryList: [GroceryItemViewModel]) -> (Void)
    func updateImageBanner(image: UIImage) -> (Void)
    func showError()
    func showLoading()
    func hideLoading()
}

protocol GroceryListPresenterProtocol: class {
    var view: GroceryListViewProtocol? { get set }
    var interactor: GroceryListInteractorInputProtocol? { get set }
    var imageInteractor: ImageInteractorProtocol? { get set }
    var cartInteractor: CartInteractorProtocol? { get set }
    var router: GroceryListRouterProtocol? { get set }
    
    func viewDidLoad()
    func onAddToCart(cartItem: CartItem)
    func onThumbnailUpdate(imageName: String, completion: @escaping ImageClosure)
    func onTapBack() -> Void
}

protocol GroceryListInteractorInputProtocol: class {
    var presenter: GroceryListInteractorOutputProtocol? { get set }
    var remoteDataManager: GroceryListRemoteDataManagerInputProtocol? { get set }
    var localDataManager: GroceryListLocalDataManagerInputProtocol? { get set }
    
    func retrieveGroceries(using category: CategoryItemViewModel, addCartItemClosure: @escaping AddCartItemClosure)
}

protocol GroceryListInteractorOutputProtocol: class {
    func didRetrieveGroceries(groceries: [GroceryItemViewModel], imageBannerName: String)
    func onError()
}

protocol GroceryListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: GroceryListRemoteDataManagerOutputProtocol? { get set }
    
    func retrieveGroceries(using category: CategoryItemViewModel, addCartItemClosure: @escaping AddCartItemClosure)
}

protocol GroceryListRemoteDataManagerOutputProtocol: class {
    func onGroceriesRetrieved(groceries: [GroceryItemViewModel], imageBannerName: String)
    func onError()
}

protocol GroceryListLocalDataManagerInputProtocol: class {
    func retrieveGroceries(using category: CategoryItemViewModel) throws -> [GroceryItemViewModel]
    func saveGroceries(_ groceries: [GroceryItemViewModel]) throws
}

protocol GroceryListRouterProtocol: class {
    func navigateBackToCategoryList()
}
