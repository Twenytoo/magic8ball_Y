//
//  AnswerViewModelType.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation

protocol AnswerViewModelType {
    var answers: [Answer]! { get set }
    func getAnswers()
}
