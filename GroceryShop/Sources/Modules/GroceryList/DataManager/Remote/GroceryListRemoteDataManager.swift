//
//  GroceryListRemoteDataManager.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import Alamofire

class GroceryListRemoteDataManager {
    private lazy var httpService = HttpService()
    static let shared = GroceryListRemoteDataManager()
    var remoteRequestHandler: GroceryListRemoteDataManagerOutputProtocol?
}

extension GroceryListRemoteDataManager: GroceryListRemoteDataManagerInputProtocol {
    
    func retrieveGroceries(using category: CategoryItemViewModel, addCartItemClosure: @escaping AddCartItemClosure) {
        let categoryId = category.id
        do {
            try GroceryHttpRouter
                .getGroceries(categoryId: categoryId)
                .request(usingHttpService: httpService)
                .responseJSON { [weak self] (response) in
                    let groceryListResponse = GroceryListRemoteDataManager.parseGroceryListResponse(response: response)
                    let groceries = groceryListResponse?.groceriesData.groceries.map { grocery in
                        return GroceryItemViewModel(using: grocery)
                    }
                    let groceryList = addCartItemClosure(groceries ?? [])
                    self?.remoteRequestHandler?.onGroceriesRetrieved(groceries: groceryList, imageBannerName: groceryListResponse?.image.name ?? "")
                }
        }
        catch {
            debugPrint("Something went wrong while fetching groceries: \(error)")
        }
    }
}

extension GroceryListRemoteDataManager {
    
    private static func parseGroceryListResponse(response: AFDataResponse<Any>) -> CategoryGroceryListResponse? {
        guard [200, 201].contains(response.response?.statusCode), let data = response.data
        else { return nil }
        do {
            let singleResult = try JSONDecoder().decode(GroceryListResponse.self, from: data)
            return singleResult.category
        }
        catch {
            debugPrint("Something went wrong while parsing groceries response: \(error)")
            return nil
        }
    }
}
