//
//  AnwersModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation

protocol AnswersModelType {
    var storageManager: StorageServiceProtocol { get set }
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void))
}
class AnswersModel: AnswersModelType {
    var storageManager: StorageServiceProtocol
    init(storagemanager: StorageServiceProtocol) {
        self.storageManager = storagemanager
    }
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void)) {
        storageManager.getAnswersFromDB { answers in
            completion(answers)
        }
    }
}
