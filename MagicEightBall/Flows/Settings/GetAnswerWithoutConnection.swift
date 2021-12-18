//
//  GetAnswerWithoutConnection.swift
//  MagicEightBall
//
//  Created by Артём on 28.11.2021.
//

import Foundation
import RxSwift

protocol GetAnswerFromDBProtocol: AnyObject {
    func showAnswerWithoutConnection() -> String
}
class GetAnswerWithoutConnection: GetAnswerFromDBProtocol {
    private let storageManager: StorageServiceProtocol
    private let disposeBag = DisposeBag()
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
    }
    func showAnswerWithoutConnection() -> String {
        var answer = L10n.error
        storageManager.answerRx
            .map { $0.map { $0.text ?? L10n.error }}
            .subscribe(onNext: {
                answer = $0.randomElement() ?? L10n.error
            }).disposed(by: disposeBag)
        return answer
    }
}
