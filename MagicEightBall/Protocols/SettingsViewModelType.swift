//
//  SettingViewModelType.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation

protocol SettingsViewModelType {
    var storageManager: StorageService { get set }
    func addNewAnswer(answer: String)
}
