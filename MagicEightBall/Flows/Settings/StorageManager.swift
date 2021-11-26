//
//  CoreDataManager.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import CoreData

enum Entities {
    case answerEntity
}
class StorageManager: StorageServiceProtocol, GetAnswerFromDBProtocol, CreateAnswerProtocol {
    let context = AppDelegate.context!
    var answers = [AnswerEntity]()
    init() {
        getAllObejcts()
    }
    func getAllObejcts() {
        do {
            answers = try context.fetch(AnswerEntity.fetchRequest())
        } catch {
            print(error)
        }
    }
    func createEntity(text: String) {
        let newEntity = AnswerEntity(context: context)
        newEntity.text = text
        newEntity.date = Date()
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    func deleteEntity(answer: AnswerEntity) {
        context.delete(answer)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    func updateEntity(answer: AnswerEntity, text: String) {
        answer.text = text
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    func showAnswerWithoutConnection() -> String {
        if let answer = self.answers.randomElement()?.text {
            return answer
        } else {
            return L10n.add
        }
    }
}
