//
//  SettingsModel.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
import RxSwift

// MARK: - Protocols
protocol SettingsModelType {
    var storageManager: StorageServiceProtocol { get set }
    func addNewAnswer(answer: String)
    func deleteAnswerAt(indexPath: Int)
//    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void))
    var answersRx: Observable<[Answer]> { get }
    var reloadTable: PublishSubject<Void> { get set}
    func getAnswersFromDBRX()
}
protocol CreateAnswerProtocol {
    func addNewAnswer(answer: String)
}
// MARK: - Class
class SettingsModel: SettingsModelType, CreateAnswerProtocol {
    var answersRx: Observable<[Answer]> {
        storageManager.answerRx.map { $0.map {$0.toAnswer()} }
    }
    var reloadTable = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    var storageManager: StorageServiceProtocol
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
//        setupBinding()
//        answersRx.subscribe(onNext: { $0.forEach { print($0.text)}})
        
    }
    func addNewAnswer(answer: String) {
        storageManager.createAnswerEntity(answer: answer)
    }
    func deleteAnswerAt(indexPath: Int) {
        storageManager.deleteAnswerAt(indexPath: indexPath)
    }
//    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void)) {
//        storageManager.getAnswersFromDB { answers in
//            completion(answers)
//        }
//    }
//    func setupBinding() {
//        reloadTable
//            .subscribe { [weak self] _ in
//            _ = self?.storageManager.getAnswersFromDBRX()
//        }
//    }
    func getAnswersFromDBRX() {
        storageManager.getAnswersFromDBRX()
    }
}

