//
//  DBHelper.swift
//  RealmSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 28/09/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

struct DBHelper {
    
    var realm: Realm!

    
    static func addObjc(obj:ClassModel) {
        try! Realm().write {
          try!  Realm().add(obj)
            print("obj..", obj.name)
        }
        
    }
    
static func getAll() {
    
    var array: NSArray = []
    
    var unsortedObjects = [Results<ClassModel>]()
    do {
    let unsortedObjects = try Realm().objects(ClassModel.self)
    print("objects..",unsortedObjects[0].value(forKey: "name"))
    
    //array = unsortedObjects[0].value(forKey: "name")

    } catch {
        print("error")
    }
    
    //return Array(array) as! [ClassModel]
   }
}
