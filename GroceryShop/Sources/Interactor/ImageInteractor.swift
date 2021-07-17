//
//  ImageInteractor.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

protocol ImageInteractorProtocol {
    var service: ImageRemoteDataManagerProtocol { get set }
    
    func fetchImage(imageName: String, completion: @escaping ImageClosure) -> (Void)
}

final class ImageInteractor: ImageInteractorProtocol {
    var service: ImageRemoteDataManagerProtocol
    
    init(service: ImageRemoteDataManagerProtocol) {
        self.service = service
    }
}

extension ImageInteractor {    
    func fetchImage(imageName: String, completion: @escaping ImageClosure) -> Void {
        self.service.fetchImage(imageName: imageName, completion: completion)
    }
}
