//
//  MainModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
// MARK: - Enum
enum MyError: String, Error {
    case invaliData         = "The data recieved from the server was invalid. Please try again! "
    case invalidURL         = "This URL created an invalid request. Please try again."
    case unableToComplete   = "Internet connection failed. You will see the answers from your store"
}
// MARK: - Protocol
protocol MainModelType {
    var countTouches: Int {get set}
    var answer: String! { get set }
    var networkManager: NetworkService { get set }
    var storageManager: StorageServiceProtocol { get set }
    var secureStorageService: SecureStorageServiceType { get set }
    func fetchAnswerByURL(completionSuccess: @escaping (String) -> Void,
                          completionError: @escaping (MyError) -> Void)
    func saveTouches()
    func loadTouches () -> Int
    func increaseTouches()
}
// MARK: - Class
class MainModel: MainModelType {
    var countTouches = 0
    var answer: String!
    var internetFetchSuccess: Bool
    var networkManager: NetworkService
    var storageManager: StorageServiceProtocol
    var secureStorageService: SecureStorageServiceType
    init(networkManager: NetworkService,
         storageManager: StorageServiceProtocol,
         secureStorageService: SecureStorageServiceType) {
        self.networkManager = networkManager
        self.storageManager = storageManager
        self.secureStorageService = secureStorageService
        self.internetFetchSuccess = true
    }
    func fetchAnswerByURL(completionSuccess: @escaping (String) -> Void,
                          completionError: @escaping (MyError) -> Void) {
        networkManager.fetchAnswerByURL { result in
            switch result {
            case.success(let answer):
                let answerString = answer.uppercased()
                completionSuccess(answerString)
            case.failure(let error):
                if self.internetFetchSuccess {
                    completionError(error)
                    self.internetFetchSuccess = false
                }
            }
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
