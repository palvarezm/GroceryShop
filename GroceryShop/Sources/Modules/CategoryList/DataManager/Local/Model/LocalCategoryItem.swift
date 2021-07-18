//
//  LocalCategoryItem.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 12/07/21.
//

import RealmSwift

class LocalCategoryItem: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var details: String = ""
    @objc dynamic var image: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension LocalCategoryItem {
    convenience init(categoryItem: CategoryItemViewModel) {
        self.init()
        self.id = categoryItem.id
        self.name = categoryItem.name
        self.details = categoryItem.details
        self.image = categoryItem.image
    }
}
