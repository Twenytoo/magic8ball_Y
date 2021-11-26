//
//  AnswerViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation

protocol AnswerViewModelType {
    var answers: [Answer] { get set }
    func addAnswer(answer: String)
    func deleteAnswer(text: String)
    func getAnswers()
    func getDateByString (indexPath: Int ) -> String
}
class AnswerViewModel: AnswerViewModelType {
    let dateFormatter = DateFormatter()
    var answers = [Answer]()
    let answerModel: AnswersModelType
    init(answerModel: AnswersModelType) {
        self.answerModel = answerModel
        getAnswers()
    }
    func getAnswers() {
        getAllObejcts()
        dateFormatter.setLocalizedDateFormatFromTemplate("MM-dd-yyyy HH:mm")
        answers = answerModel.answers.reversed()
    }
    func getAllObejcts() {
        answerModel.getAllObejcts()
    }
    func addAnswer(answer: String) {
        let answer = Answer(text: answer, date: Date())
        answers.insert(answer, at: 0)
    }
    func deleteAnswer(text: String) {
        answers = answers.filter({ $0.text != text})
    }
    func getDateByString (indexPath: Int ) -> String {
        return dateFormatter.string(from: answers[indexPath].date)
    }
}
