//
//  AnwersModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import RxSwift

protocol HistoryModelType {
    var answersRx: Observable<[Answer]> { get }
}
class HistoryModel: HistoryModelType {
    var answersRx: Observable<[Answer]> {
        storageManager.answerRx.map { $0.map {$0.toAnswer()} }
    }
    private let storageManager: StorageServiceProtocol
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
    }
}
