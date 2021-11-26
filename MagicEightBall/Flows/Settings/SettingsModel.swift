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
    var storageManager: StorageServiceProtocol
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
        fetchAnswerString()
    }
    func addNewAnswer(answer: String) {
        storageManager.createEntity(text: answer)
//        let newAnswer = Answer(name: answer)
//        storageManager.saveObject(newAnswer)
    }
    func deleteAnswer(answer: String) {
        for answerEntity in storageManager.answers where answerEntity.text == answer {
            storageManager.deleteEntity(answer: answerEntity)
        }
//        for answerTypeAnswer in storageManager.answers where answerTypeAnswer.answerText == answer {
//            storageManager.deleteObject(answerTypeAnswer)
//        }
    }
    private func fetchAnswerString() {
        var temp = [String]()
        for answer in storageManager.answers {
            temp.append(answer.text ?? "Ошибка")
        }
        self.answers = temp
    }
}
