//
//  SettingViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation

class SettingViewModel: SettingViewModelType {
    var storageManager: StorageService
    init(storageManager: StorageService) {
    self.storageManager = storageManager
    }
    /// Adds the new object of Answer type in the database
    /// Creates an instance of Answer type from String type.
    /// Then pass the object of Answer type to store it in the database
    ///
    /// - Parameter answer: Sting
    /// - Returns: Void
    func addNewAnswer(answer: String) {
        let newAnswer = Answer(name: answer)
        storageManager.saveObject(newAnswer)
    }
}
