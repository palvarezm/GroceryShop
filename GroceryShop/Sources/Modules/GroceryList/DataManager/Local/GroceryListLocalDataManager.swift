//
//  GroceryListLocalDataManager.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 18/07/21.
//

import RealmSwift

class GroceryListLocalDataManager: GroceryListLocalDataManagerInputProtocol {
    func retrieveGroceries(using category: CategoryItemViewModel) throws -> [GroceryItemViewModel] {
        let realm = try! Realm()
        let realmGroceries = realm.objects(LocalGroceryItem.self)
        let groceries: [GroceryItemViewModel] = realmGroceries.map {
            return GroceryItemViewModel(localGroceryItem: $0)
        }
        return groceries
    }
    
    func saveGroceries(_ groceries: [GroceryItemViewModel]) throws {
        do {
            let realm = try! Realm()
            try realm.write {
                let localGroceries = groceries.map {
                    LocalGroceryItem(groceryItem: $0)
                }
                realm.add(localGroceries, update: .all)
            }
        }
        catch {
            debugPrint("Something went wrong while saving groceries to local db: \(error)")
        }
    }
}
