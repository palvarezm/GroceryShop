//
//  ImageRemoteDataManagerProtocol.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 16/07/21.
//

import UIKit

typealias ImageClosure = (UIImage) -> (Void)

protocol ImageRemoteDataManagerInputProtocol {
    func fetchImage(imageName: String, completion: @escaping ImageClosure) -> Void
}
