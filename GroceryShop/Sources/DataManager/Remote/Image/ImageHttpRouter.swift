//
//  ImageHttpRouter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 16/07/21.
//

import Alamofire
import AlamofireImage

enum ImageHttpRouter {
    case downloadImage(imageName: String)
}

extension ImageHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://letscodeeasy.com/groceryapi/public/api"
    }
    
    var path: String {
        switch (self) {
        case .downloadImage(let imageName): return "/image/show/\(imageName)"
        }
    }
    
    var method: HTTPMethod {
        switch (self) {
        case .downloadImage: return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func body() throws -> Data? {
        switch (self) {
        case .downloadImage: return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseUrlString.asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        return request
    }
    
    func download(usingImageHttpService httpService: ImageHttpService, completion: @escaping ImageDataResponseClosure) throws -> Void {
        try httpService.download(asURLRequest(), completion: completion)
    }
}
