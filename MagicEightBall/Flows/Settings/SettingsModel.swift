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
    var answersRx: Observable<[Answer]> { get }
    func getAnswersFromDBRX()
    func addNewAnswer(answer: String)
    func deleteAnswerAt(indexPath: Int)
}

// MARK: - Class
class SettingsModel: SettingsModelType {
    var answersRx: Observable<[Answer]> {
        storageManager.answerRx.map { $0.map {$0.toAnswer()} }
    }
//    private let disposeBag = DisposeBag()
    private let storageManager: StorageServiceProtocol
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
    }
    func addNewAnswer(answer: String) {
        storageManager.createAnswerEntity(answer: answer)
    }
    func deleteAnswerAt(indexPath: Int) {
        storageManager.deleteAnswerAt(indexPath: indexPath)
    }
    func getAnswersFromDBRX() {
        storageManager.getAnswersFromDBRX()
    }
}
