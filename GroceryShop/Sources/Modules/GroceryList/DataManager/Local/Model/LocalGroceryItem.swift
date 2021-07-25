//
//  LocalGroceryItem.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import RealmSwift

class LocalGroceryItem: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var categoryId: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var details: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var price: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension LocalGroceryItem {
    convenience init(groceryItem: GroceryItemViewModel) {
        self.init()
        self.id = groceryItem.id
        self.categoryId = groceryItem.categoryId
        self.title = groceryItem.title
        self.details = groceryItem.details
        self.image = groceryItem.image
        self.price = groceryItem.price
    }
}
