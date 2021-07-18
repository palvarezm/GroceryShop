//
//  GroceryHttpRouter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 12/07/21.
//

import Alamofire

enum GroceryHttpRouter {
    case getCategories
}

extension GroceryHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://letscodeeasy.com/groceryapi/public/api"
    }
    
    var path: String {
        switch (self) {
        case .getCategories: return "/categories"
        }
    }
    
    var method: HTTPMethod {
        switch (self) {
        case .getCategories: return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
    }
    
    var parameters: Parameters?{
        return nil
    }
    
    func body() throws -> Data? {
        switch (self) {
        case .getCategories: return nil
        }
    }
}
