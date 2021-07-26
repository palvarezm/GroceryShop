//
//  GroceryListPresenter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import Foundation

typealias AddCartItemClosure = ([GroceryItemViewModel]) -> ([GroceryItemViewModel])

class GroceryListPresenter: GroceryListPresenterProtocol {
    var view: GroceryListViewProtocol?
    var interactor: GroceryListInteractorInputProtocol?
    var imageInteractor: ImageInteractorProtocol?
    var cartInteractor: CartInteractorProtocol?
    var router: GroceryListRouterProtocol?
    
    var category: CategoryItemViewModel
    
    init(view: GroceryListViewProtocol, interactor: GroceryListInteractorInputProtocol, imageInteractor: ImageInteractorProtocol, cartInteractor: CartInteractorProtocol, router: GroceryListRouterProtocol, category: CategoryItemViewModel) {
        self.view = view
        self.interactor = interactor
        self.imageInteractor = imageInteractor
        self.cartInteractor = cartInteractor
        self.router = router
        self.category = category
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveGroceries(using: category) { [weak self] groceries in
            let safeCategoryId = "\(self?.category.id ?? 0)"
            let categoryGroceryList = groceries.filter { $0.categoryId == safeCategoryId }
            return categoryGroceryList.map { grocery -> GroceryItemViewModel in
                let cartItem = self?.cartInteractor?.getCartItem(id: grocery.id)
                guard let safeCartItem = cartItem else { return grocery }
                let itemCounterViewModel = ItemCounterViewModel(id: safeCartItem.id, counterValue: safeCartItem.value)
                var result = grocery
                result.itemCounterViewModel = itemCounterViewModel
                return result
            }
        }
    }
    
    func onThumbnailUpdate(imageName: String, completion: @escaping ImageClosure) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.imageInteractor?.fetchImage(imageName: imageName, completion: completion)
        }
    }
    
    func onAddToCart(cartItem: CartItem) {
        DispatchQueue.global(qos: .background).async {
            self.cartInteractor?.addToCart(cartItem: cartItem)
        }
    }
    
    func onTapBack() {
        router?.navigateBackToCategoryList()
    }
    
    func onDismissErrorAlert() {
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
    let id: String
    let categoryId: String
    let title: String
    let details: String
    let image: String
    let price: String
    var itemCounterViewModel: ItemCounterViewModel
    
    init(using grocery: GroceryResponse) {
        self.id = String(describing: grocery.id)
        self.categoryId = String(describing: grocery.categoryId)
        self.price = grocery.skuData.skus.first?.price.formatAsStringPrice() ?? ""
        self.title = grocery.title
        self.details = grocery.details
        self.image = grocery.image.name
        self.itemCounterViewModel = ItemCounterViewModel()
    }
    
    init(localGroceryItem: LocalGroceryItem) {
        self.id = String(describing: localGroceryItem.id)
        self.categoryId = localGroceryItem.categoryId
        self.title = localGroceryItem.title
        self.details = localGroceryItem.details
        self.image = localGroceryItem.image
        self.price = localGroceryItem.price
        self.itemCounterViewModel = ItemCounterViewModel()
    }
}
