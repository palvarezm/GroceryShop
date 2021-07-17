//
//  CategoryListPresenter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

class CategoryListPresenter {
    weak var view: CategoryListViewControllerProtocol?
    var interactor: CategoryListInteractorInputProtocol?
    var router: CategoryListRouterProtocol
    
    init(view: CategoryListViewControllerProtocol, router: CategoryListRouterProtocol, interactor: CategoryListInteractorInputProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension CategoryListPresenter: CategoryListPresenterProtocol {
        
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveCategories()
    }
    
    func onTapCategoryItem(usingCategory category: CategoryItemViewModel) {
        
    }
}

extension CategoryListPresenter: CategoryListInteractorOutputProtocol {
    func didRetrieveCategories(_ categories: [CategoryItemViewModel]) {
        view?.hideLoading()
        view?.showCategories(with: categories)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}

struct CategoryItemViewModel {
    let id: Int
    let name: String
    let details: String
    let image: String
    
    init(using categoryModel: CategoryResponse) {
        self.id = categoryModel.id
        self.name = categoryModel.category
        self.details = categoryModel.details
        self.image = categoryModel.image.name
    }
    
    init(localCategoryItem: LocalCategoryItem) {
        self.id = localCategoryItem.id
        self.name = localCategoryItem.name
        self.details = localCategoryItem.details
        self.image = localCategoryItem.image
    }
}
