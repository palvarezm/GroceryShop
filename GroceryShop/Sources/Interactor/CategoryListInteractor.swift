//
//  CategoryListInteractor.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import RealmSwift

class CategoryListInteractor: CategoryListInteractorInputProtocol {
    weak var presenter: CategoryListInteractorOutputProtocol?
    var localDataManager: CategoryListLocalDataManagerInputProtocol?
    var remoteDataManager: CategoryListRemoteDataManagerInputProtocol?
        
    func retrieveCategories() {
        do {
            if let localCategories = try localDataManager?.retrieveCategories() {
                if localCategories.isEmpty {
                    remoteDataManager?.retrieveCategories()
                }
                else {
                    presenter?.didRetrieveCategories(localCategories)
                }
            }
            else {
                remoteDataManager?.retrieveCategories()
            }
        }
        catch {
            presenter?.didRetrieveCategories([])
        }
    }
}

extension CategoryListInteractor: CategoryListRemoteDataManagerOutputProtocol {
    func onCategoriesRetrieved(_ categories: [CategoryItemViewModel]) {
        presenter?.didRetrieveCategories(categories)
        do {
            try localDataManager?.saveCategories(categories: categories)
        }
        catch {
            debugPrint("Something went wrong when saving categories to local db: \(error)")
        }
    }
    
    func onError() {
        presenter?.onError()
    }
}
