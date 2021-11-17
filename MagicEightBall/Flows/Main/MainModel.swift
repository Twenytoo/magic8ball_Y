//
//  MainModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation

class MainModel: MainModelType {
    var networkManager: NetworkService
    var storageManager: StorageService
    lazy var completionHandler = networkManager.completionHandler
    init(networkManager: NetworkService = NetworkManager(),
         storageManager: StorageService = StorageManager()) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
    func fetchAnswerByURL() -> String {
        let answer = networkManager.fetchAnswerByURL()
        return answer
    }
}
