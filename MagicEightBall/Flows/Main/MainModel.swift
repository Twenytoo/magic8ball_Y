//
//  MainModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
import RxSwift

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
    func loadTouches()
    func increaseTouches()
    //rx
    var countTouchesRX: BehaviorSubject<Int> {get set}
}
// MARK: - Class
class MainModel: MainModelType {
    //  Rx
    var countTouchesRX = BehaviorSubject(value: 0)
    //    OLD
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
        var new = 0
        countTouchesRX
            .map{$0 + 1}
            .subscribe { value in
                new = value
            }
        countTouchesRX.onNext(new)
    }
    func saveTouches() {
        countTouchesRX.subscribe { event in
            switch event {
            case .next(let count):
                if count == 1 {
                    self.secureStorageService.saveData(key: StorageKey.keyForTouches,
                                                       value: count,
                                                       dictionary: StorageDictionary.countOfTouches)
                } else {
                    self.secureStorageService.updateData(key: StorageKey.keyForTouches,
                                                         value: count,
                                                         dictionary: StorageDictionary.countOfTouches)
                }
            case .error(let error):
                print(error)
            case .completed:
                print("Completed")
            }
        }
    }
    func loadTouches() {
        let touches = secureStorageService.loadData(key: StorageKey.keyForTouches,
                                                    dictionary: StorageDictionary.countOfTouches) as? Int
        countTouchesRX.onNext(touches ?? 0)
    }
}
