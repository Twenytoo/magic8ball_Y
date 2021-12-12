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
    var answer: String! { get set }
    var networkManager: NetworkService { get set }
    var storageManager: StorageServiceProtocol { get set }
    var secureStorageService: SecureStorageServiceType { get set }
    func loadTouches()
//    Rx
    var countTouchesRX: BehaviorSubject<Int> {get set}
    var ballDidShake: PublishSubject<Void> {get set}
    var answerRx: PublishSubject<Answer> {get set}
}
// MARK: - Class
class MainModel: MainModelType {
    //  Rx
    var countTouchesRX = BehaviorSubject(value: 0)
    var ballDidShake = PublishSubject<Void>()
    var answerRx = PublishSubject<Answer>()
    private let disposeBag = DisposeBag()

    //    OLD
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
        setupBinding()
    }
    private func increaseTouches() {
        var new = 0
        countTouchesRX
            .map { $0 + 1 }
            .subscribe { value in
                new = value
            }.disposed(by: disposeBag)
        countTouchesRX.onNext(new)
    }
    private func saveTouches() {
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
        }.disposed(by: disposeBag)
    }
    func loadTouches() {
        let touches = secureStorageService.loadData(key: StorageKey.keyForTouches,
                                                    dictionary: StorageDictionary.countOfTouches) as? Int
        countTouchesRX.onNext(touches ?? 0)
    }
    func setupBinding() {
        _ = ballDidShake.subscribe { [weak self] _ in
            self?.increaseTouches()
            self?.saveTouches()
            self?.networkManager.fetchAnswerByURLRX()
        }
        _ = networkManager.answerRx.bind(to: answerRx)
    }
}
