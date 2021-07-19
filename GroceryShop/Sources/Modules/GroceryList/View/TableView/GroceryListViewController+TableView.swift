//
//  GroceryListViewController+TableView.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 19/07/21.
//

import UIKit

extension GroceryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = groceryList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GroceryTableViewCell.identifier) as! GroceryTableViewCell
        cell.configure(itemViewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
