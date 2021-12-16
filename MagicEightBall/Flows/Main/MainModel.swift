//
//  MainModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
import RxSwift

// MARK: - Errors
enum MyError: String, Error {
    case invaliData         = "The data recieved from the server was invalid. Please try again! "
    case invalidURL         = "This URL created an invalid request. Please try again."
    case unableToComplete   = "Internet connection failed. You will see the answers from your store"
}
// MARK: - Protocol
protocol MainModelType {
    func loadTouches()
    var countTouchesRX: BehaviorSubject<Int> {get set}
    var ballDidShake: PublishSubject<Void> {get set}
    var answerRx: Observable<Answer> { get }
}
// MARK: - Class
class MainModel: MainModelType {
    var countTouchesRX = BehaviorSubject(value: 0)
    var ballDidShake = PublishSubject<Void>()
    var answerRx: Observable<Answer> {
        networkManager.answerRx
    }
    private let disposeBag = DisposeBag()
    private let networkManager: NetworkService
    private let storageManager: StorageServiceProtocol
    private let secureStorageService: SecureStorageServiceType
    init(networkManager: NetworkService,
         storageManager: StorageServiceProtocol,
         secureStorageService: SecureStorageServiceType) {
        self.networkManager = networkManager
        self.storageManager = storageManager
        self.secureStorageService = secureStorageService
        setupBinding()
    }
    func loadTouches() {
        let touches = secureStorageService.loadData(key: StorageKey.keyForTouches,
                                                    dictionary: StorageDictionary.countOfTouches) as? Int
        countTouchesRX.onNext(touches ?? 0)
    }
}
// MARK: - Private funcs
private extension MainModel {
    func increaseTouches() {
        var new = 0
        countTouchesRX
            .map { $0 + 1 }
            .subscribe { value in
                new = value
            }.disposed(by: disposeBag)
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
        }.disposed(by: disposeBag)
    }
    func setupBinding() {
        ballDidShake.subscribe { [weak self] _ in
            self?.increaseTouches()
            self?.saveTouches()
            self?.networkManager.fetchAnswerByURLRX()
        }.disposed(by: disposeBag)
    }
}
