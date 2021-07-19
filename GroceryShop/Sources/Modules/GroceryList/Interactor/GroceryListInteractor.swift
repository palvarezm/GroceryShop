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
    
    func retrieveGroceries(using category: CategoryItemViewModel) {
        do {
            if let groceryList = try localDataManager?.retrieveGroceries(using: category) {
                if groceryList.isEmpty {
                    remoteDataManager?.retrieveGroceries(using: category)
                }
                else {
                    presenter?.didRetrieveGroceries(groceries: groceryList, imageBannerName: category.image)
                }
            }
            else {
                remoteDataManager?.retrieveGroceries(using: category)
            }
        }
        catch {
            presenter?.didRetrieveGroceries(groceries: [], imageBannerName: category.image)
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
