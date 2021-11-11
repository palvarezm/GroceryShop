//
//  CategoryListLocalDataManager.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 12/07/21.
//

import RealmSwift

class CategoryListLocalDataManager: CategoryListLocalDataManagerInputProtocol {
    func retrieveCategories() throws -> [CategoryItemViewModel] {
        let realm = try! Realm()
        let categories = realm.objects(LocalCategoryItem.self)
        return categories.map { CategoryItemViewModel(localCategoryItem: $0)}
    }
    
    func saveCategories(categories: [CategoryItemViewModel]) throws {
        do {
            let realm = try! Realm()
            try realm.write {
                let realmCategories = categories.map { LocalCategoryItem(categoryItem: $0)}
                realm.add(realmCategories, update: .all)
            }
        }
        catch {
            debugPrint("Something went wrong with REALM DB: \(error)")
        }
    }
}
