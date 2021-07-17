//
//  HttpService.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 10/07/21.
//

import Alamofire

final class HttpService {
    var session = Session.default
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return session.request(urlRequest).validate(statusCode: 200..<400)
    }
}
