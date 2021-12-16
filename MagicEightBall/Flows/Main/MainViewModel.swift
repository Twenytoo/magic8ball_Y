//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import UIKit
import RxSwift

// MARK: - Protocol
protocol MainViewModelType {
    var countTouchesRX: Observable<Int> { get }
    var ballDidShake: PublishSubject<Void> { get }
    var answerRx: Observable<String> { get }
    func loadTouches()
    func getAnimationAnswer() -> String
}
// MARK: - Class
class MainViewModel: MainViewModelType {
    var countTouchesRX: Observable<Int> {
        mainModel.countTouchesRX
    }
    var ballDidShake: PublishSubject<Void> {
        mainModel.ballDidShake
    }
    var answerRx: Observable<String> {
        mainModel.answerRx.map { $0.text }
    }
    private let mainModel: MainModelType
    init(mainModel: MainModelType) {
        self.mainModel = mainModel
    }
    func loadTouches() {
        mainModel.loadTouches()
    }
    func getAnimationAnswer() -> String {
        return AnswersForAnimation.answers.randomElement()!
    }
}
