//
//  Item.swift
//  Sprout
//
//  Created by Deniz Dilbilir on 24/10/2023.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCollection = LinkingObjects(fromType: Collection.self, property: "items")
    
}
