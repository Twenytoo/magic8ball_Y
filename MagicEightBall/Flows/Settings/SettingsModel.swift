//
//  SettingsModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation

// MARK: - Protocols
protocol SettingsModelType {
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
    var storageManager: StorageServiceProtocol
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
    }
    func addNewAnswer(answer: String) {
        storageManager.createAnswerEntity(answer: answer)
    }
    func deleteAnswer(answer: String) {
        storageManager.deleteEnity(answer: answer)
    }
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void)) {
        storageManager.getAnswersFromDB { answers in
            completion(answers)
        }
    }
}
