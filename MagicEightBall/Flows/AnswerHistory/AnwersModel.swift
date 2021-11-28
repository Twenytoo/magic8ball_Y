//
//  AnwersModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import CoreData

protocol AnswersModelType {
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void))
    var storageManager: StorageServiceProtocol { get set }
}
class AnswersModel: AnswersModelType {
    private let context: NSManagedObjectContext?
    weak var fetchControllerDelegate: NSFetchedResultsControllerDelegate?
    var storageManager: StorageServiceProtocol
    init(storagemanager: StorageServiceProtocol) {
        self.storageManager = storagemanager
        self.context = storagemanager.context
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
}
