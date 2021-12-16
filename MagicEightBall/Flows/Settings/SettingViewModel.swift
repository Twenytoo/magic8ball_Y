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
    var settingsModel: SettingsModelType {get set}
//    func getAnswer(indexPath: Int) -> String
//    func getCountOfAnswers() -> Int
    func addNewAnswer(answer: String)
    func deleteAnswerAt(indexPath: Int)
//    func getTextOfAnswer(indexPath: Int) -> String
    var answersRx: Observable<[String]> {get }
    var reloadTable: PublishSubject<Void> { get }
    func getAnswersFromDBRX()
}
// MARK: - Class
class SettingViewModel: SettingsViewModelType {
    var reloadTable: PublishSubject<Void> {
        settingsModel.reloadTable
    }
    var answersRx: Observable<[String]> {
        settingsModel.answersRx.map { $0.map {$0.text}}
    }
    private let disposeBag = DisposeBag()
    var settingsModel: SettingsModelType
    init(settingsModel: SettingsModelType) {
        self.settingsModel = settingsModel
//        settingsModel.answersRx.subscribe(onNext: { $0.forEach { print($0.text)}}).disposed(by: disposeBag)
//        answersRx.subscribe(onNext: { $0.forEach { print($0)}})
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
//    func getAnswer(indexPath: Int) -> String {
//        var answer = ""
//        settingsModel.getAnswersFromDB { answers in
//            answer = answers[indexPath].text ?? L10n.error
//        }
//        return answer
//    }
//    func getCountOfAnswers() -> Int {
//        var count = 0
//        settingsModel.getAnswersFromDB { answers in
//            count = answers.count
//        }
//        return count
//    }
//    func getTextOfAnswer(indexPath: Int) -> String {
//        var answerText = ""
//        settingsModel.getAnswersFromDB { answers in
//            answerText = answers[indexPath].text ?? L10n.error
//        }
//        return answerText
//    }
}
