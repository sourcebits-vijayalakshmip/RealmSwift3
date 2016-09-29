//
//  ClassModel.swift
//  RealmSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 28/09/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import Foundation
import RealmSwift

class ClassModel: Object {
    
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        
        return "name"
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
