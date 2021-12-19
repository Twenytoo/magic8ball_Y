//
//  AnswerViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation
import RxSwift

protocol HistoryViewModelType {
    var answersRx: Observable<[String]> { get }
}
class HistoryViewModel: HistoryViewModelType {
    var answersRx: Observable<[String]> {
        model.answersRx.map { $0.map {$0.text}}
    }
    private let dateFormatter: DateFormatter
    private let model: HistoryModelType
    init(model: HistoryModelType, dateFormatter: DateFormatter = DateFormatter()) {
        self.model = model
        self.dateFormatter = dateFormatter
        self.dateFormatter.setLocalizedDateFormatFromTemplate("MM-dd-yyyy HH:mm")
    }
}
