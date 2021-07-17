//
//  ImageRemoteDataManager.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 17/07/21.
//

import Alamofire

class ImageRemoteDataManager {
    private lazy var imageHttpService = ImageHttpService.shared
    static let shared = ImageRemoteDataManager()
}

extension ImageRemoteDataManager: ImageRemoteDataManagerProtocol {
    
    func fetchImage(imageName: String, completion: @escaping ImageClosure) {
        do {
            try ImageHttpRouter
                .downloadImage(imageName: imageName)
                .download(usingImageHttpService: imageHttpService) { response in
                    switch (response.result) {
                    case .success(let image):
                        completion(image)
                        break
                    case .failure(let error):
                        debugPrint("Something went wrong while fetching the image: \(error)")
                        break
                    }
                }
        }
        catch {
            debugPrint("Something went wrong while fetching the image: \(error)")
        }
    }
}
