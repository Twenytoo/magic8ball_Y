//
//  SettingViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation
import RealmSwift

class SettingViewModel: SettingsViewModelType {
    var answers: [String]!
    var settingsModel: SettingsModelType
    init(settingsModel: SettingsModelType) {
        self.settingsModel = settingsModel
        fullAnswers()
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
    func fullAnswers() {
        var temp = [String]()
        if let answers = settingsModel.answers {
            for answer in answers {
                temp.append(answer)
            }
        }
        self.answers = temp
    }
}
