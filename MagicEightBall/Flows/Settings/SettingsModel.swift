//
//  SettingsModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
import RealmSwift

class SettingsModel: SettingsModelType {
    var answers: [String]?
    var storageManager: StorageServiceProtocol & CreateAnswerProtocol
    init(storageManager: StorageServiceProtocol & CreateAnswerProtocol) {
        self.storageManager = storageManager
        fetchAnswerString()
    }
    func addNewAnswer(answer: String) {
        storageManager.createEntity(text: answer)
    }
    func deleteAnswer(answer: String) {
        for answerEntity in storageManager.answers where answerEntity.text == answer {
            storageManager.deleteEntity(answer: answerEntity)
        }
    }
    private func fetchAnswerString() {
        var temp = [String]()
        for answer in storageManager.answers {
            temp.append(answer.text ?? L10n.error)
        }
        self.answers = temp
    }
}
