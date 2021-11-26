//
//  StorageService.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation
import RealmSwift
import CoreData

protocol StorageServiceProtocol {
//    var answers: Results<Answer>! { get set}
    var answers: [AnswerEntity] { get set}
//    func saveObject (_ answer: Answer)
//    func deleteObject (_ answer: Answer)
    func createEntity(text: String)
    func deleteEntity(answer: AnswerEntity)
    func updateEntity(answer: AnswerEntity, text: String)
}
