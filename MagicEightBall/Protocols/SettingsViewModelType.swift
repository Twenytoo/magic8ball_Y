//
//  SettingViewModelType.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation
import RealmSwift

protocol SettingsViewModelType {
    var answers: [String]! { get set }
    var settingsModel: SettingsModelType {get set}
    func addNewAnswer(answer: String)
    func deleteAnswer(answer: String)
}
