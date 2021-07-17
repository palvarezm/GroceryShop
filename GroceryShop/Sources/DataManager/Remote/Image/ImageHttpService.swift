//
//  ImageHttpService.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 16/07/21.
//

import Alamofire
import AlamofireImage

typealias ImageDataResponseClosure = (AFIDataResponse<Image>) -> (Void)

final class ImageHttpService {
    static let shared: ImageHttpService = ImageHttpService()
    let imageDownloader: ImageDownloader
    
    init() {
        self.imageDownloader = ImageDownloader()
    }
    
    func download(_ urlRequest: URLRequestConvertible, completion: @escaping ImageDataResponseClosure) -> Void {
        imageDownloader.download(urlRequest, completion: completion)
    }
}
