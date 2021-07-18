//
//  CategoryListProtocols.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import UIKit

protocol CategoryListViewControllerProtocol: class {
    var presenter: CategoryListPresenterProtocol? { get set }
    
    func showCategories(with categories: [CategoryItemViewModel])
    func showError()
    func showLoading()
    func hideLoading()
}

protocol CategoryListPresenterProtocol: class {
    var view: CategoryListViewControllerProtocol? { get set }
    var interactor: CategoryListInteractorInputProtocol? { get set }
    var imageInteractor: ImageInteractorProtocol? { get set }
    var router: CategoryListRouterProtocol { get set }
    
    func viewDidLoad() -> Void
    func onFetchImage(imageName: String, completion: @escaping ImageClosure)
    func onTapCategoryItem(usingCategory category: CategoryItemViewModel)
}

protocol CategoryListInteractorOutputProtocol: class {
    func didRetrieveCategories(_ categories: [CategoryItemViewModel])
    func onError()
}

protocol CategoryListInteractorInputProtocol: class {
    var presenter: CategoryListInteractorOutputProtocol? { get set }
    var localDataManager: CategoryListLocalDataManagerInputProtocol? { get set }
    var remoteDataManager: CategoryListRemoteDataManagerInputProtocol? { get set }
    
    func retrieveCategories()
}

protocol CategoryListDataManagerInputProtocol: class {
    
}

protocol CategoryListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: CategoryListRemoteDataManagerOutputProtocol? { get set }
    
    func retrieveCategories()
}

protocol CategoryListRemoteDataManagerOutputProtocol: class {
    func onCategoriesRetrieved(_ categories: [CategoryItemViewModel])
    func onError()
}

protocol CategoryListLocalDataManagerInputProtocol: class {
    func retrieveCategories() throws -> [CategoryItemViewModel]
    func saveCategories(categories:  [CategoryItemViewModel]) throws
}

protocol CategoryListRouterProtocol: class {
    func navigateToCategoryGroceries(usingCategory category: CategoryItemViewModel)
}
