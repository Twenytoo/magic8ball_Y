//
//  SettingViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation
//MARK: - Protocols
protocol SettingsViewModelType {
    var answers: [String] { get set }
    var settingsModel: SettingsModelType {get set}
    func addNewAnswer(answer: String)
    func deleteAnswer(answer: String)
}
//MARK: - Class
class SettingViewModel: SettingsViewModelType {
    var answers = [String]()
    var settingsModel: SettingsModelType
    init(settingsModel: SettingsModelType) {
        self.settingsModel = settingsModel
        getAnswerFromEntity()
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
    func deleteAnswer(answer: String) {
        settingsModel.deleteAnswer(answer: answer)
    }
    func getAnswerFromEntity() {
       settingsModel.getAnswersFromDB { answerEntity in
            var answersString = [String]()
            for answer in answerEntity {
                answersString.append(answer.text ?? L10n.error)
            }
            self.answers = answersString
        }
    }
}
