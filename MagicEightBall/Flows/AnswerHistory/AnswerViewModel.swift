//
//  AnswerViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation

protocol AnswerViewModelType {
    var answers: [Answer]! { get set }
    func getAnswers()
}
class AnswerViewModel: AnswerViewModelType {
    var answers: [Answer]!
    let answerModel: AnswersModelType
    init(answerModel: AnswersModelType) {
        self.answerModel = answerModel
        getAnswers()
    }
    func getAnswers() {
        getAllObejcts()
        answers = answerModel.answers.reversed()
    }
    func getAllObejcts() {
        answerModel.getAllObejcts()
    }
}
