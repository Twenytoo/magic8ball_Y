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
    private let settingsModel: SettingsModelType
    private let disposeBag = DisposeBag()
    var answersRx: Observable<[String]> {
        settingsModel.answersRx.map { $0.map {$0.text}}
    }
    init(settingsModel: SettingsModelType) {
        self.settingsModel = settingsModel
    }
    func getAnswersFromDBRX() {
        settingsModel.getAnswersFromDBRX()
    }
    func addNewAnswer(answer: String) {
        settingsModel.addNewAnswer(answer: answer)
    }
    func deleteAnswerAt(indexPath: Int) {
        settingsModel.deleteAnswerAt(indexPath: indexPath)
    }
}
