//
//  AnwersModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation

protocol AnswersModelType {
    var answers: [Answer]! { get set }
    func getAllObejcts()
    var storageManager: StorageServiceProtocol { get set }
}
class AnswersModel: AnswersModelType {
    let dateFormatter = DateFormatter()
    var answers: [Answer]!
    var storageManager: StorageServiceProtocol
    init(storagemanager: StorageServiceProtocol) {
        self.storageManager = storagemanager
        fetchAnswerString()
        dateFormatter.dateStyle = .medium
    }
    private func fetchAnswerString() {
        var temp = [Answer]()
        for answer in storageManager.answers {
            temp.append(Answer(text: answer.text ?? "", date: answer.date ?? Date()))
        }
        self.answers = temp
    }
    func getAllObejcts() {
        fetchAnswerString()
        storageManager.getAllObejcts()
    }
}
