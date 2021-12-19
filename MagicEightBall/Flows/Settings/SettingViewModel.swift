//
//  SettingViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation
import RxSwift
// MARK: - Protocols
protocol SettingsViewModelType {
    func addNewAnswer(answer: String)
    func deleteAnswerAt(indexPath: Int)
    var answersRx: Observable<[String]> {get }
    func getAnswersFromDBRX()
}
// MARK: - Class
class SettingViewModel: SettingsViewModelType {
    private let model: SettingsModelType
    private let disposeBag = DisposeBag()
    var answersRx: Observable<[String]> {
        model.answersRx.map { $0.map {$0.text}}
    }
    init(model: SettingsModelType) {
        self.model = model
    }
    func getAnswersFromDBRX() {
        model.getAnswersFromDBRX()
    }
    func addNewAnswer(answer: String) {
        model.addNewAnswer(answer: answer)
    }
    func deleteAnswerAt(indexPath: Int) {
        model.deleteAnswerAt(indexPath: indexPath)
    }
}
