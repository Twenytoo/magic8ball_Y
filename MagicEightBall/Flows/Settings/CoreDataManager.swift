//
//  CoreDataManager.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import CoreData

class CoreDataManager: StorageServiceProtocol, DBManagerProtocol {
    let context = AppDelegate.context!
    var answers = [AnswerEntity] ()
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
        return "ЗАГЛУШКА"
    }
}
