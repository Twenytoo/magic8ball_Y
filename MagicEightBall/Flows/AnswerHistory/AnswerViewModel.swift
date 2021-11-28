//
//  AnswerViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation

protocol AnswerViewModelType {
    func getAnswerFromEntity(complition: @escaping ([Answer]) -> Void)
    func getTextOfAnswer(indexPath: Int) -> String
    func getDateOfAnswer(indexPath: Int) -> String 
}
class AnswerViewModel: AnswerViewModelType {
    let dateFormatter = DateFormatter()
    let answerModel: AnswersModelType
    init(answerModel: AnswersModelType) {
        self.answerModel = answerModel
        dateFormatter.setLocalizedDateFormatFromTemplate("MM-dd-yyyy HH:mm")
    }
    func getAnswerFromEntity(complition: @escaping ([Answer]) -> Void) {
            answerModel.getAnswersFromDB { answersEntity in
                var answersArray = [Answer]()
                for answerEntity in answersEntity {
                    let answer = Answer(text: answerEntity.text ?? L10n.error, date: answerEntity.date ?? Date())
                    answersArray.append(answer)
                }
                complition(answersArray)
            }
        }
    func getTextOfAnswer(indexPath: Int) -> String {
        var answerText = ""
        answerModel.getAnswersFromDB { answers in
            answerText = answers[indexPath].text ?? L10n.error
        }
        return answerText
    }
    func getDateOfAnswer(indexPath: Int) -> String {
        var answerDate = ""
        answerModel.getAnswersFromDB { [weak self] answers in
            answerDate = self?.dateFormatter.string(from: answers[indexPath].date ?? Date()) ?? L10n.error
        }
        return answerDate
    }
}
