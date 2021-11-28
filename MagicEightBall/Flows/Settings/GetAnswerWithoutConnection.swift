//
//  GetAnswerWithoutConnection.swift
//  MagicEightBall
//
//  Created by Артём on 28.11.2021.
//

import Foundation
import CoreData

protocol GetAnswerFromDBProtocol: AnyObject {
    func showAnswerWithoutConnection() -> String
}
class GetAnswerWithoutConnection: GetAnswerFromDBProtocol {
    var storageManager: StorageServiceProtocol
    private let context: NSManagedObjectContext?
    private let fetchRequest = NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
        self.context = storageManager.context
    }
    func showAnswerWithoutConnection() -> String {
        guard let context = context else { return L10n.error}
        var answerText = ""
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        storageManager.getObjects(fetchController: controller) { [weak self] result in
            switch result {
            case .success(let answerEntities):
                answerText = self?.getRandomTextFromEntities(entities: answerEntities) ?? L10n.error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return answerText
    }
    private func getRandomTextFromEntities(entities: [AnswerEntity]) -> String {
        guard let text = entities.randomElement()?.text else { return L10n.error}
        return text
    }
}
