//
//  CategoryListTableViewController+TableView.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 12/07/21.
//

import UIKit

extension CategoryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
        let categoryViewModel = categories[indexPath.row]
        cell.categoryCard.categoryViewModel = categoryViewModel
        cell.categoryCard.setHandler { [weak self] category in
            debugPrint("\(category)")
            self?.presenter?.onTapCategoryItem(usingCategory: category)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.onTapCategoryItem(usingCategory: categories[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
