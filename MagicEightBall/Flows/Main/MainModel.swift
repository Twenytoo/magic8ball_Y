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
    lazy var completionHandler = networkManager.completionHandler
    init(networkManager: NetworkService = NetworkManager(),
         storageManager: StorageService = StorageManager()) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }

    func fetchAnswerByURL(completion: @escaping (String?) -> Void) {
        networkManager.fetchAnswerByURL { answer in
            completion(answer)
        }
    }
//        func fetchAnswerByURL(completion: @escaping (String?) -> Void) {
//            networkManager.fetchAnswerByURL { answer in
//                completion(answer)
//            }
//        }
}
