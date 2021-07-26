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
    @IBOutlet weak var imageBannerHeightConstraint: NSLayoutConstraint!
    
    var presenter: GroceryListPresenterProtocol?
    
    var groceryList: [GroceryItemViewModel] = []
    var previousOffsetState: CGFloat = 0

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
        if groceryList.isEmpty {
            groceryListTableView.setEmptyTableView(title: "empty_grocery_list_title".localized, subtitle: "empty_grocery_list_subtitle".localized)
        }
        else {
            groceryListTableView.resetFromEmptyTableView()
        }
    }
    
    func updateImageBanner(image: UIImage) {
        categoryImageBanner.image = image
        categoryImageBanner.contentMode = .scaleAspectFill
    }
    
    func showError() {
        showInfoAlert(message: "generic_error".localized) { [weak self] _ in
            self?.presenter?.onDismissErrorAlert()
        }
    }
    
    func showLoading() {
        LoadingIndicatorView.show(self.view, loadingText: "loading_view_text".localized)
    }
    
    func hideLoading() {
        LoadingIndicatorView.hide()
    }
}
