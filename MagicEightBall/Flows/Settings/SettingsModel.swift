//
//  SettingsModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
import CoreData

class SettingsModel: SettingsModelType {
    var answers = [AnswerEntity]()
    var storageManager: StorageServiceProtocol & CreateAnswerProtocol
    init(storageManager: StorageServiceProtocol & CreateAnswerProtocol) {
        self.storageManager = storageManager
    }
    func addNewAnswer(answer: String) {
        storageManager.createEntity(text: answer)
        getAnswersFromDB()
    }
    func deleteAnswer(answer: String) {
        for answerEntity in storageManager.answers where answerEntity.text == answer {
            storageManager.deleteEntity(answer: answerEntity)
        }
    }
    func getAnswersFromDB() {
        let fetchRequest = NSFetchRequest<AnswerEntity>(entityName: "AnswerEntity")
        storageManager.getObjects(fetchRequest) { result in
                switch result {
                case .success(let answerEntities):
                    self.setAnswers(answer: answerEntities)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    func setAnswers(answer: [AnswerEntity]){
        answers = answer
    }
}
