//
//  SettingViewModelType.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation

protocol SettingViewModelType {
    var storageManager: StorageService { get set }
    func addNewAnswer(answer: String)
}
