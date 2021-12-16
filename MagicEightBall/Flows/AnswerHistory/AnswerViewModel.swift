//
//  AnswerViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import RxSwift

protocol AnswerViewModelType {
//    func getAnswerFromEntity(complition: @escaping ([Answer]) -> Void)
//    func getTextOfAnswer(indexPath: Int) -> String
//    func getDateOfAnswer(indexPath: Int) -> String
//    func getCountOfAnswers() -> Int
    var answersRx: Observable<[String]> { get }
}
class AnswerViewModel: AnswerViewModelType {
    var answersRx: Observable<[String]> {
        answerModel.answersRx.map { $0.map {$0.text}}
    }
    let dateFormatter: DateFormatter
    let answerModel: AnswersModelType
    init(answerModel: AnswersModelType, dateFormatter: DateFormatter = DateFormatter()) {
        self.answerModel = answerModel
        self.dateFormatter = dateFormatter
        self.dateFormatter.setLocalizedDateFormatFromTemplate("MM-dd-yyyy HH:mm")
    }
//    func getAnswerFromEntity(complition: @escaping ([Answer]) -> Void) {
//            answerModel.getAnswersFromDB { answersEntity in
//                let answersArray = answersEntity.map {$0.toAnswer()}
//                complition(answersArray)
//            }
//        }
//    func getTextOfAnswer(indexPath: Int) -> String {
//        var answerText = ""
//        answerModel.getAnswersFromDB { answers in
//            answerText = answers[indexPath].text ?? L10n.error
//        }
//        return answerText
//    }
//    func getDateOfAnswer(indexPath: Int) -> String {
//        var answerDate = ""
//        answerModel.getAnswersFromDB { [weak self] answers in
//            answerDate = self?.dateFormatter.string(from: answers[indexPath].date ?? Date()) ?? L10n.error
//        }
//        return answerDate
//    }
//    func getCountOfAnswers() -> Int {
//        var count = 0
//        answerModel.getAnswersFromDB { answers in
//            count = answers.count
//        }
//        return count
//    }
}
