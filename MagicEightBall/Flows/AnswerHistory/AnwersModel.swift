//
//  AnwersModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import RxSwift

protocol AnswersModelType {
    var storageManager: StorageServiceProtocol { get set }
    var answersRx: Observable<[Answer]> { get }
//    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void))
}
class AnswersModel: AnswersModelType {
    var answersRx: Observable<[Answer]> {
        storageManager.answerRx.map { $0.map {$0.toAnswer()} }
    }
    var storageManager: StorageServiceProtocol
    init(storagemanager: StorageServiceProtocol) {
        self.storageManager = storagemanager
    }
//    func getAnswersFromDB(completion: @escaping (([AnswerEntity]) -> Void)) {
//        storageManager.getAnswersFromDB { answers in
//            completion(answers)
//        }
//    }
}
