//
//  CategoryListViewController.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 11/07/21.
//

import UIKit

class CategoryListViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    var presenter: CategoryListPresenterProtocol?
    var categories: [CategoryItemViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.register(UINib(nibName: String(describing: CategoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        presenter?.viewDidLoad()
    }

}

extension CategoryListViewController: CategoryListViewControllerProtocol {
    func showCategories(with categories: [CategoryItemViewModel]) {
        self.categories = categories
        categoriesTableView.reloadData()
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        LoadingIndicatorView.show(self.view, loadingText: "loading_view_text".localized)
    }
    
    func hideLoading() {
        LoadingIndicatorView.hide()
    }
}
