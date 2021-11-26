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
    var storageManager: StorageServiceProtocol & CreateAnswerProtocol { get set }
    func addNewAnswer(answer: String)
    func deleteAnswer(answer: String)
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void))
}
// MARK: - Class
class SettingsModel: SettingsModelType {
    var answers = [AnswerEntity]()
    var storageManager: StorageServiceProtocol & CreateAnswerProtocol
    init(storageManager: StorageServiceProtocol & CreateAnswerProtocol) {
        self.storageManager = storageManager
    }
    func addNewAnswer(answer: String) {
        storageManager.createEntity(text: answer)
        //    МОЖЕТ ТУТ НЕ ХВАТАЕТ ФУНКЦИИ getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> [String]))
    }
    func deleteAnswer(answer: String) {
        for answerEntity in storageManager.answers where answerEntity.text == answer {
            storageManager.deleteEntity(answer: answerEntity)
        }
    }
    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void))  {
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
    func setAnswers(answer: [AnswerEntity]){
        answers = answer
    }
}
