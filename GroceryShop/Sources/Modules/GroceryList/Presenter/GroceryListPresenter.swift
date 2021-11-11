//
//  GroceryListPresenter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import Foundation

typealias AddCartItemClosure = ([GroceryItemViewModel]) -> ([GroceryItemViewModel])
typealias GroceryListUseCases = (
    retrieveGroceries: (_ category: CategoryItemViewModel, _ addCartItemClosure: @escaping AddCartItemClosure) -> (Void),
    fetchImage: (_ imageName: String, _ completion: @escaping ImageClosure) -> (Void),
    getCartItem: (String) -> (CartItem),
    addToCart: (CartItem) -> (Void)
)

class GroceryListPresenter: GroceryListPresenterProtocol {
    var view: GroceryListViewProtocol?
    var groceryListsUseCases: GroceryListUseCases?
    var router: GroceryListRouterProtocol?
    
    var category: CategoryItemViewModel
    
    init(view: GroceryListViewProtocol, useCases: GroceryListUseCases, router: GroceryListRouterProtocol, category: CategoryItemViewModel) {
        self.view = view
        self.groceryListsUseCases = useCases
        self.router = router
        self.category = category
    }
    
    func viewDidLoad() {
        view?.showLoading()
        groceryListsUseCases?.retrieveGroceries(category) { [weak self] groceries in
            let safeCategoryId = "\(self?.category.id ?? 0)"
            let categoryGroceryList = groceries.filter { $0.categoryId == safeCategoryId }
            return categoryGroceryList.map { grocery -> GroceryItemViewModel in
                let cartItem = self?.groceryListsUseCases?.getCartItem(grocery.id)
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
            self?.groceryListsUseCases?.fetchImage(imageName, completion)
        }
    }
    
    func onAddToCart(cartItem: CartItem) {
        DispatchQueue.global(qos: .background).async {
            self.groceryListsUseCases?.addToCart(cartItem)
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
            self?.groceryListsUseCases?.fetchImage(imageBannerName) { [weak self] image in
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
