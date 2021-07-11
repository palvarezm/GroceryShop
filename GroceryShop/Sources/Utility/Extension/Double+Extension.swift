//
//  Double+Extension.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 10/07/21.
//

extension Double {
    func formatAsStringPrice() -> String {
        return "$ \(String(format: "%.2f", self))"
    }
}
