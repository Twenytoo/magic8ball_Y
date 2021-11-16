//
//  StorageManager.swift
//  MagicEightBall
//
//  Created by Артём on 19.10.2021.
//

import RealmSwift

// Сreating the function for saving and deleting objects from the database
// Entry point for working with the Realm database
let realm = StorageManager.createRealm()

// Manager for working with Realm database
class StorageManager: StorageService {
    // The array for answers from Realm
    var answers: Results<Answer>!
    /// Saves the object of Answer type in the database
    ///
    /// Pass the object of Answer type to store it in the database
    ///
    /// - Parameter answer: an instance of Answer
    /// - Returns: Void
    func saveObject(_ answer: Answer) {
        do {
            try? realm.write {
                realm.add(answer)
            }
        }
    }
    /// Removes the object of Answer type in the database
    ///
    /// Pass the object of Answer type to delete it in the database
    ///
    /// - Parameter answer: an instance of Answer
    /// - Returns: Void
    func deleteObject(_ answer: Answer) {
        do {
            try? realm.write {
                realm.delete(answer)
            }
        }
    }
    // Creating realm instatce
    static func createRealm() -> Realm {
        do {
          return try Realm()
        } catch let error as NSError {
          fatalError("Error opening realm: \(error)")
        }
      }

}
