//
//  CategoryListRemoteDataManager.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 12/07/21.
//

import Alamofire

class CategoryListRemoteDataManager {
    private lazy var httpService = HttpService()
    static let shared = CategoryListRemoteDataManager()
    var remoteRequestHandler: CategoryListRemoteDataManagerOutputProtocol?
}

extension CategoryListRemoteDataManager: CategoryListRemoteDataManagerInputProtocol {
    
    func retrieveCategories() {
        do {
            try GroceryHttpRouter
                .getCategories
                .request(usingHttpService: httpService)
                .responseJSON { [weak self] (response) in
                    let responseCategories = CategoryListRemoteDataManager.parseCategories(response: response)
                    let categories = responseCategories.categoryList.compactMap { (category) ->
                        CategoryItemViewModel in
                        return CategoryItemViewModel(using: category)
                    }
                    self?.remoteRequestHandler?.onCategoriesRetrieved(categories)
                }
        }
        catch {
            debugPrint("Something went wrong while fetch categories = \(error)")
            remoteRequestHandler?.onError()
        }
    }
}
 
extension CategoryListRemoteDataManager {
    private static func parseCategories(response: AFDataResponse<Any>) -> CategoryListResponse {
        guard [200, 201].contains(response.response?.statusCode), let data = response.data
        else {
            return CategoryListResponse(categoryList: [])
        }
        do {
            return try JSONDecoder().decode(CategoryListResponse.self, from: data)
        }
        catch {
            debugPrint("Something went wrong while parsing categories response = \(error)")
        }
        return CategoryListResponse(categoryList: [])
    }
}
