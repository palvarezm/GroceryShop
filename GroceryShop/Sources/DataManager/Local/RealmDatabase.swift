//
//  RealmDatabase.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 10/07/21.
//

import RealmSwift

class RealmDatabase {
    static let shared: RealmDatabase = RealmDatabase()
    var notificationToken: NotificationToken?
    
    private init() { }
    
    deinit {
        notificationToken?.invalidate()
    }
}
