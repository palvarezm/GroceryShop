//
//  UIViewController+Extension.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 25/07/21.
//

import UIKit

extension UIViewController {
    func showInfoAlert(message: String, completion: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok_alert".localized, style: .default, handler: completion))
        alert.show(self, sender: nil)
        self.present(alert, animated: true, completion: nil)
    }
}
