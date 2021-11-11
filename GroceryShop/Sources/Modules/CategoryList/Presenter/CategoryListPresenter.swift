//
//  CategoryListPresenter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import Foundation

typealias CategoryListUseCases = (
    retrieveCategories: () -> (Void),
    fetchImage: (_ imageName: String, _ completion: @escaping ImageClosure) -> (Void)
)

class CategoryListPresenter {
    weak var view: CategoryListViewControllerProtocol?
    var categoryListUseCases: CategoryListUseCases?
    var router: CategoryListRouterProtocol
    
    init(view: CategoryListViewControllerProtocol, router: CategoryListRouterProtocol, useCases: CategoryListUseCases?) {
        self.view = view
        self.router = router
        self.categoryListUseCases = useCases
    }
}

extension CategoryListPresenter: CategoryListPresenterProtocol {
     
    func viewDidLoad() {
        view?.showLoading()
        categoryListUseCases?.retrieveCategories()
    }
    
    func onFetchImage(imageName: String, completion: @escaping ImageClosure) {
        categoryListUseCases?.fetchImage(imageName, completion)
    }
    
    func onTapCategoryItem(usingCategory category: CategoryItemViewModel) {
        router.navigateToCategoryGroceries(usingCategory: category)
    }
}

extension CategoryListPresenter: CategoryListInteractorOutputProtocol {
    func didRetrieveCategories(_ categories: [CategoryItemViewModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.view?.showCategories(with: categories)
        }
    }
    
    func onError() {
        DispatchQueue.main.async { [weak self] in 
            self?.view?.hideLoading()
            self?.view?.showError()
        }
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
