//
//  CategoryListResponse.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

struct CategoryListResponse: Codable {
    let categoryList: [CategoryResponse]
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "data"
    }
}

struct CategoryResponse: Codable {
    let id: Int
    let category: String
    let details: String
    let image: BaseImage
}
