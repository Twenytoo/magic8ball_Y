//
//  AnwersModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import RxSwift

protocol AnswersModelType {
    var answersRx: Observable<[Answer]> { get }
}
class AnswersModel: AnswersModelType {
    var answersRx: Observable<[Answer]> {
        storageManager.answerRx.map { $0.map {$0.toAnswer()} }
    }
    private let storageManager: StorageServiceProtocol
    init(storagemanager: StorageServiceProtocol) {
        self.storageManager = storagemanager
    }
}
