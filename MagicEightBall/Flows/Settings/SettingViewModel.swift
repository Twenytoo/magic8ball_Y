//
//  SettingViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation
// MARK: - Protocols
protocol SettingsViewModelType {
    var settingsModel: SettingsModelType {get set}
    func getAnswer(indexPath: Int) -> String
    func getCountOfAnswers() -> Int
    func addNewAnswer(answer: String)
    func deleteAnswerAt(indexPath: Int)
    func getTextOfAnswer(indexPath: Int) -> String
}
// MARK: - Class
class SettingViewModel: SettingsViewModelType {
    var settingsModel: SettingsModelType
    init(settingsModel: SettingsModelType) {
        self.settingsModel = settingsModel
    }
    /// Adds the new object of Answer type in the database
    /// Creates an instance of Answer type from String type.
    /// Then pass the object of Answer type to store it in the database
    ///
    /// - Parameter answer: Sting
    /// - Returns: Void
    func addNewAnswer(answer: String) {
        settingsModel.addNewAnswer(answer: answer)
    }
    func deleteAnswerAt(indexPath: Int) {
        settingsModel.deleteAnswerAt(indexPath: indexPath)
    }
    func getAnswer(indexPath: Int) -> String {
        var answer = ""
        settingsModel.getAnswersFromDB { answers in
            answer = answers[indexPath].text ?? L10n.error
        }
        return answer
    }
    func getCountOfAnswers() -> Int {
        var count = 0
        settingsModel.getAnswersFromDB { answers in
            count = answers.count
        }
        return count
    }
    func getTextOfAnswer(indexPath: Int) -> String {
        var answerText = ""
        settingsModel.getAnswersFromDB { answers in
            answerText = answers[indexPath].text ?? L10n.error
        }
        return answerText
    }
}
