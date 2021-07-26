//
//  UITableView+Extension.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 25/07/21.
//

import UIKit

extension UITableView {
    func setEmptyTableView(title: String, subtitle: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(subtitleLabel)

        titleLabel.text = title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true

        subtitleLabel.text = subtitle
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textColor = UIColor.lightGray
        subtitleLabel.font = titleLabel.font.withSize(16)
        subtitleLabel.textAlignment = .center
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func resetFromEmptyTableView() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
