//
//  GroceryListViewController.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import UIKit

class GroceryListViewController: UIViewController {

    var presenter: GroceryListPresenterProtocol?
    
    var groceryList: [GroceryItemViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension GroceryListViewController: GroceryListViewProtocol {
    
    func showGroceryList(groceryList: [GroceryItemViewModel]) {
        self.groceryList = groceryList
        debugPrint(groceryList)
    }
    
    func updateImageBanner(image: UIImage) {
        debugPrint("Image updated")
    }
    
    func showError() {
        debugPrint("Error")
    }
    
    func showLoading() {
        LoadingIndicatorView.show(self.view, loadingText: "loading_view_text".localized)
    }
    
    func hideLoading() {
        LoadingIndicatorView.hide()
    }
}
