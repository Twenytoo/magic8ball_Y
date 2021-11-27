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
    var storageManager: StorageServiceProtocol
    init(storagemanager: StorageServiceProtocol) {
        self.storageManager = storagemanager
    }
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void)) {
        let fetchRequest = NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
        storageManager.getObjects(fetchRequest) { result in
            switch result {
            case .success(let answerEntities):
                completion(answerEntities)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
