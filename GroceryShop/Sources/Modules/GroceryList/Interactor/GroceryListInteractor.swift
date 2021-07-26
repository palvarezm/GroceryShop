//
//  GroceryListInteractor.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

class GroceryListInteractor: GroceryListInteractorInputProtocol {
    var presenter: GroceryListInteractorOutputProtocol?
    var remoteDataManager: GroceryListRemoteDataManagerInputProtocol?
    var localDataManager: GroceryListLocalDataManagerInputProtocol?
    
    func retrieveGroceries(using category: CategoryItemViewModel, addCartItemClosure: @escaping AddCartItemClosure) {
        do {
            if let groceryList = try localDataManager?.retrieveGroceries(using: category) {
                let locallyStoredCategories = Set(groceryList.map { $0.categoryId })
                let stringCategoryId = String(describing: category.id)
                if !locallyStoredCategories.contains(stringCategoryId) {
                    remoteDataManager?.retrieveGroceries(using: category, addCartItemClosure: addCartItemClosure)
                }
                else {
                    let groceriesResult = addCartItemClosure(groceryList)
                    presenter?.didRetrieveGroceries(groceries: groceriesResult, imageBannerName: category.image)
                }
            }
            else {
                remoteDataManager?.retrieveGroceries(using: category, addCartItemClosure: addCartItemClosure)
            }
        }
        catch {
            presenter?.onError()
        }
    }
}

extension GroceryListInteractor: GroceryListRemoteDataManagerOutputProtocol {
    
    func onGroceriesRetrieved(groceries: [GroceryItemViewModel], imageBannerName: String) {
        presenter?.didRetrieveGroceries(groceries: groceries, imageBannerName: imageBannerName)
        do {
            try localDataManager?.saveGroceries(groceries)
        }
        catch {
            debugPrint("Something went wrong while saving groceries to local db: \(error)")
        }
    }
    
    func onError() {
        presenter?.onError()
    }
}
