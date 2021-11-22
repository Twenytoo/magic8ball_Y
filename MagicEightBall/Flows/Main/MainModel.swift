//
//  MainModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation

class MainModel: MainModelType {
    var answer: String!
    var networkManager: NetworkService
    var storageManager: StorageService
    var secureStorageService: SecureStorageServiceType
    lazy var completionHandler = networkManager.completionHandler
    init(networkManager: NetworkService,
         storageManager: StorageService,
         secureStorageService: SecureStorageServiceType) {
        self.networkManager = networkManager
        self.storageManager = storageManager
        self.secureStorageService = secureStorageService
    }

    func fetchAnswerByURL(completion: @escaping (String?) -> Void) {
        networkManager.fetchAnswerByURL { answer in
            completion(answer)
        }
    }
    func saveTouches() {
        secureStorageService.countTouches += 1
        secureStorageService.saveTouches()
        secureStorageService.loadTouches()
    }
}
