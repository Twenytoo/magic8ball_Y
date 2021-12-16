//
//  AnswerViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import RxSwift

protocol AnswerViewModelType {
    var answersRx: Observable<[String]> { get }
}
class AnswerViewModel: AnswerViewModelType {
    var answersRx: Observable<[String]> {
        answerModel.answersRx.map { $0.map {$0.text}}
    }
    private let dateFormatter: DateFormatter
    private let answerModel: AnswersModelType
    init(answerModel: AnswersModelType, dateFormatter: DateFormatter = DateFormatter()) {
        self.answerModel = answerModel
        self.dateFormatter = dateFormatter
        self.dateFormatter.setLocalizedDateFormatFromTemplate("MM-dd-yyyy HH:mm")
    }
}
