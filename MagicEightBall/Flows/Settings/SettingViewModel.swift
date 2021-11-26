//
//  SettingViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation


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
        settingsModel.getAnswersFromDB()
        print("getAnswersFromDB CALLED settingsModel")
        let entyties = settingsModel.answers
        print(entyties.count)
        for entity in entyties {
            print("TEXT!!!!!\(String(describing: entity.text))")
            let answer = entity.text ?? L10n.error
            self.answers.append(answer)
        }
    }
}
