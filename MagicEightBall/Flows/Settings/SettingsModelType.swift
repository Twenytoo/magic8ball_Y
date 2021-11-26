//
//  SettingsModelType.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation

protocol SettingsModelType {
    var answers: [AnswerEntity] { get set }
    var storageManager: StorageServiceProtocol & CreateAnswerProtocol { get set }
    func addNewAnswer(answer: String)
    func deleteAnswer(answer: String)
    func getAnswersFromDB()
}
