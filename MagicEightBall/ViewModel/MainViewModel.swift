//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation

class MainViewModel: MainViewModelType {
    var networkManager: NetworkService
    var storageManager: StorageService
    var customView: CustomViewForMainVC
    
    init(networkManager: NetworkService,
         storageManager: StorageService,
         customView: CustomViewForMainVC) {
        self.networkManager = networkManager
        self.storageManager = storageManager
        self.customView = customView
    }

}
