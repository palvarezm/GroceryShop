//
//  UIVIew+Extension.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 10/07/21.
//

import UIKit

extension UIView {
    static var identifier: String {
        return "\(String(describing: self))Identifier"
    }
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
