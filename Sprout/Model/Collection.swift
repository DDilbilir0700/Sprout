//
//  Collection.swift
//  Sprout
//
//  Created by Deniz Dilbilir on 24/10/2023.
//

import Foundation
import RealmSwift

class Collection: Object {
    
    @objc dynamic var name: String = ""
   let items = List<Item>()
    
    
}
