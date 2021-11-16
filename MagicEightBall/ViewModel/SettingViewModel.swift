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
}
