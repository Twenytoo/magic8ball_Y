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
    var storageManager: StorageService
    init(storageManager: StorageService = StorageManager()) {
        self.storageManager = storageManager
        fetchAnswerString()
    }
    func addNewAnswer(answer: String) {
        let newAnswer = Answer(name: answer)
        storageManager.saveObject(newAnswer)
    }
    func deleteAnswer(answer: String) {
        for answerTypeAnswer in storageManager.answers where answerTypeAnswer.answerText == answer {
            storageManager.deleteObject(answerTypeAnswer)
        }
    }
    func fetchAnswerString() {
        var temp = [String]()
        for answer in storageManager.answers {
            temp.append(answer.answerText)
        }
        self.answers = temp
    }
}
