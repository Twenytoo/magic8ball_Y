//
//  SettingsModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
import CoreData
// MARK: - Protocols
protocol SettingsModelType {
    var answers: [AnswerEntity] { get set }
    var storageManager: StorageServiceProtocol { get set }
    func addNewAnswer(answer: String)
    func deleteAnswer(answer: String)
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void))
}
protocol CreateAnswerProtocol {
    func addNewAnswer(answer: String)
}
// MARK: - Class
class SettingsModel: SettingsModelType, CreateAnswerProtocol {
    var answers = [AnswerEntity]()
    private let context: NSManagedObjectContext?
    private let fetchRequest = NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
    var storageManager: StorageServiceProtocol
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
        self.context = storageManager.context
        setAnswers()
    }
    func addNewAnswer(answer: String) {
        guard let context = context else { return }
        let newEntity = AnswerEntity(context: context)
            newEntity.text = answer
            newEntity.date = Date()
            storageManager.saveContext()
    }
    func deleteAnswer(answer: String) {
        guard let context = context else { return }
        for answerEntity in self.answers where answerEntity.text == answer {
            context.delete(answerEntity)
        }
    }
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void)) {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        storageManager.getObjects(fetchController: controller) { result in
            switch result {
            case .success(let answerEntities):
                completion(answerEntities)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func setAnswers() {
        getAnswersFromDB { answers in
            self.answers = answers
        }
    }
}
