//
//  CoreDataManager.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import CoreData
// MARK: - Protocols
protocol StorageServiceProtocol {
    var delegate: SettingsModelType? { get set}
    func getObjects<T: NSManagedObject> (
            _ request: NSFetchRequest<T>,
            completion: @escaping (Result<[T], Error>) -> Void
        )
    func deleteEntity(answer: AnswerEntity)
    func updateEntity(answer: AnswerEntity, text: String)
}
protocol GetAnswerFromDBProtocol: AnyObject {
    func showAnswerWithoutConnection() -> String
}
protocol CreateAnswerProtocol {
    func createEntity(text: String)
}
// MARK: - Class
class StorageManager: StorageServiceProtocol, GetAnswerFromDBProtocol, CreateAnswerProtocol {
    var delegate: SettingsModelType?
    let context = AppDelegate.context!
    init() {
    }
    public func getObjects<T: NSManagedObject> (
            _ request: NSFetchRequest<T>,
            completion: @escaping (Result<[T], Error>) -> Void
        ) {
            let context = context
            context.perform {
                do {
                    let result = try context.fetch(request)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    func createEntity(text: String) {
        let newEntity = AnswerEntity(context: context)
        newEntity.text = text
        newEntity.date = Date()
        saveContext()
    }
    func deleteEntity(answer: AnswerEntity) {
        context.delete(answer)
        saveContext()
    }
    func updateEntity(answer: AnswerEntity, text: String) {
        answer.text = text
        saveContext()
    }
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    func showAnswerWithoutConnection() -> String {
        if let answer = delegate?.answers.randomElement()?.text {
            return answer
        } else {
            return L10n.add
        }
    }
}
