//
//  GroceryListResponse.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

struct GroceryListResponse: Codable {
    let category: CategoryGroceryListResponse
    
    private enum CodingKeys: String, CodingKey {
        case category = "data"
    }
}

struct CategoryGroceryListResponse: Codable {
    let id: Int
    let category: String
    let details: String
    let image: BaseImage
    let groceriesData: GroceriesData
    
    private enum CodingKeys: String, CodingKey {
        case id
        case category
        case details
        case image
        case groceriesData = "groceries"
    }
}

struct GroceriesData: Codable {
    let groceries: [GroceryResponse]
    
    private enum CodingKeys: String, CodingKey {
        case groceries = "data"
    }
}

struct GroceryResponse: Codable {
    let id: Int
    let title: String
    let details: String
    let categoryId: Int
    let imageId: Int
    let image: BaseImage
    let skuData: SkuData
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case details
        case categoryId
        case imageId = "image_id"
        case image
        case skuData = "skus"
    }
}

struct SkuData: Codable {
    let skus: [Sku]
    
    private enum CodingKeys: String, CodingKey {
        case skus = "data"
    }
}

struct Sku: Codable {
    let skuId: Int
    let groceryId: Int
    let quantity: Int
    let weight: Double
    let price: Double
    
    private enum CodingKeys: String, CodingKey {
        case skuId
        case groceryId = "grocery_id"
        case quantity
        case weight
        case price
    }
}
