//
//  MainModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
// MARK: - Protocol
protocol MainModelType {
    var countTouches: Int {get set}
    var answer: String! { get set }
    var networkManager: NetworkService { get set }
    var storageManager: StorageServiceProtocol { get set }
    var secureStorageService: SecureStorageServiceType { get set }
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL(completion: @escaping (_ answer: String?) -> Void)
    func saveTouches()
    func loadTouches () -> Int
    func increaseTouches()
}
// MARK: - Class
class MainModel: MainModelType {
    var countTouches = 0
    var answer: String!
    var networkManager: NetworkService
    var storageManager: StorageServiceProtocol
    var secureStorageService: SecureStorageServiceType
    lazy var completionHandler = networkManager.completionHandler
    init(networkManager: NetworkService,
         storageManager: StorageServiceProtocol,
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
    func increaseTouches() {
        countTouches += 1
    }
    func saveTouches() {
        if countTouches == 1 {
            secureStorageService.saveData(key: StorageKey.keyForTouches,
                                          value: countTouches,
                                          dictionary: StorageDictionary.countOfTouches)
        } else {
            secureStorageService.updateData(key: StorageKey.keyForTouches,
                                            value: countTouches,
                                            dictionary: StorageDictionary.countOfTouches)
        }
    }
    func loadTouches () -> Int {
        let touches = secureStorageService.loadData(key: StorageKey.keyForTouches,
                                                          dictionary: StorageDictionary.countOfTouches) as? Int
        countTouches = touches ?? 0
        return countTouches
    }
}
