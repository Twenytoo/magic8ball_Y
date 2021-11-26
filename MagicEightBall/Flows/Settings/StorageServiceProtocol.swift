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
    var answers: [AnswerEntity] { get set}
    func createEntity(text: String)
    func deleteEntity(answer: AnswerEntity)
    func updateEntity(answer: AnswerEntity, text: String)
}
