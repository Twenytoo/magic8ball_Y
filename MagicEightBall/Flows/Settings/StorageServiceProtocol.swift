//
//  StorageService.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation
import CoreData

protocol StorageServiceProtocol {
    var answers: [AnswerEntity] { get set}
    func getObjects<T: NSManagedObject> (
            _ request: NSFetchRequest<T>,
            completion: @escaping (Result<[T], Error>) -> Void
        )
    func getAllObejcts()
    func deleteEntity(answer: AnswerEntity)
    func updateEntity(answer: AnswerEntity, text: String)
}
