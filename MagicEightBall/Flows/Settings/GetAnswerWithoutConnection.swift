//
//  GetAnswerWithoutConnection.swift
//  MagicEightBall
//
//  Created by Артём on 28.11.2021.
//

import Foundation
import CoreData

protocol GetAnswerFromDBProtocol: AnyObject {
    func showAnswerWithoutConnection() -> String
}
class GetAnswerWithoutConnection: GetAnswerFromDBProtocol {
    var storageManager: StorageServiceProtocol
    init(storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
    }
    func showAnswerWithoutConnection() -> String {
        var text = L10n.error
        storageManager.getAnswersFromDB { answers in
            text = answers.randomElement()?.text ?? L10n.error
        }
        return text
    }
}
