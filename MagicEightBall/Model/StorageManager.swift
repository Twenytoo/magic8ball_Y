//
//  StorageManager.swift
//  MagicEightBall
//
//  Created by Артём on 19.10.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject (_ answer: Answer) {
        
        try! realm.write {
            realm.add(answer)
        }
    }
    
    static func deleteObject (_ answer: Answer) {
        
        try! realm.write {
            realm.delete(answer)
        }
    }
    
    
}
