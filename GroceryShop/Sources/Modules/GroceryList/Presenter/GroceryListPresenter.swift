//
//  GroceryListPresenter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import Foundation

class GroceryListPresenter: GroceryListPresenterProtocol {
    var view: GroceryListViewProtocol?
    var interactor: GroceryListInteractorInputProtocol?
    var imageInteractor: ImageInteractorProtocol?    
    var router: GroceryListRouterProtocol?
    
    var category: CategoryItemViewModel
    
    init(view: GroceryListViewProtocol, interactor: GroceryListInteractorInputProtocol, imageInteractor: ImageInteractorProtocol, router: GroceryListRouterProtocol, category: CategoryItemViewModel) {
        self.view = view
        self.interactor = interactor
        self.imageInteractor = imageInteractor
        self.router = router
        self.category = category
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveGroceries(using: category)
    }
    
    func onAddToCart() {
        
    }
    
    func onTapBack() {
        router?.navigateBackToCategoryList()
    }
}

extension GroceryListPresenter: GroceryListInteractorOutputProtocol {
    
    func didRetrieveGroceries(groceries: [GroceryItemViewModel], imageBannerName: String) {
        view?.hideLoading()
        view?.showGroceryList(groceryList: groceries)
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.imageInteractor?.fetchImage(imageName: imageBannerName) { [weak self] image in
                DispatchQueue.main.async {
                    self?.view?.updateImageBanner(image: image)
                }
            }
        }
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}

struct GroceryItemViewModel {
    let skuId: String
    let title: String
    let details: String
    let image: String
    let price: String
    
    init(using grocery: GroceryResponse) {
        let sku = grocery.skuData.skus.first
        self.skuId = String(describing: sku?.skuId)
        self.title = grocery.title
        self.details = grocery.details
        self.image = grocery.image.name
        if let numericPrice = sku?.price {
            self.price = numericPrice.formatAsStringPrice()
        }
        else {
            self.price = ""
        }
    }
}
