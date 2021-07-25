//
//  GroceryListViewController.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import UIKit

class GroceryListViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var categoryImageBanner: UIImageView!
    @IBOutlet weak var groceryListTableView: UITableView!
    
    var presenter: GroceryListPresenterProtocol?
    
    var groceryList: [GroceryItemViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicatorView.show(view.self, loadingText: "loading_view_text".localized)
        backButton.setTitle("", for: .normal)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        categoryImageBanner.image = UIImage(named: "category-placeholder")
        groceryListTableView.delegate = self
        groceryListTableView.dataSource = self
        groceryListTableView.register(UINib(nibName: String(describing: GroceryTableViewCell.self), bundle: nil), forCellReuseIdentifier: GroceryTableViewCell.identifier)
        presenter?.viewDidLoad()
    }

    @IBAction func onBackButtonTap(_ sender: Any) {
        presenter?.onTapBack()
    }
}

extension GroceryListViewController: GroceryListViewProtocol {
    
    func showGroceryList(groceryList: [GroceryItemViewModel]) {
        self.groceryList = groceryList
        self.groceryListTableView.reloadData()
        debugPrint(groceryList)
    }
    
    func updateImageBanner(image: UIImage) {
        categoryImageBanner.image = image
        categoryImageBanner.contentMode = .scaleAspectFill
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
