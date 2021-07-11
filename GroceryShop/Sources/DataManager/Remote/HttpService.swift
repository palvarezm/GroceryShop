//
//  HttpService.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 10/07/21.
//

import Alamofire

protocol HttpService {
    var session: Session { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
