//
//  StorageManager.swift
//  MagicEightBall
//
//  Created by Артём on 19.10.2021.
//

import RealmSwift
import CoreData

///// Entry point for working with the Realm database
//let realm = StorageManager.createRealm()
//
///// Manager for working with Realm database
//class StorageManager: StorageServiceProtocol, DBManagerProtocol {
//    var answers: [NSManagedObject]
//    
//    var answerEntities: [NSManagedObject]!
//    
//    /// The array for answers from Realm
//    var answers: Results<Answer>!
//    init() {
//        answers = realm.objects(Answer.self)
//    }
//    /// Saves the object of Answer type in the database
//    ///
//    /// Pass the object of Answer type to store it in the database
//    ///
//    /// - Parameter answer: an instance of Answer
//    /// - Returns: Void
//    func saveObject(_ answer: Answer) {
//        do {
//            try? realm.write {
//                realm.add(answer)
//            }
//        }
//    }
//    /// Removes the object of Answer type in the database
//    ///
//    /// Pass the object of Answer type to delete it in the database
//    ///
//    /// - Parameter answer: an instance of Answer
//    /// - Returns: Void
//    func deleteObject(_ answer: Answer) {
//        do {
//            try? realm.write {
//                realm.delete(answer)
//            }
//        }
//    }
//    // Creating realm instatce
//    static func createRealm() -> Realm {
//        do {
//          return try Realm()
//        } catch let error as NSError {
//          fatalError("Error opening realm: \(error)")
//        }
//      }
//    /// Returns the answer from database in case of unsuccessful internet connection
//    /// Takes a random element from the database and turns it into string format. If the database is empty.
//    /// It will inform the user that new answers need to be added.
//    ///
//    /// - Returns: Answer of String type
//    func showAnswerWithoutConnection() -> String {
//        if let answer = self.answers.randomElement()?.answerText {
//            return answer
//        } else {
//            return L10n.add
//        }
//    }
//}
