//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import UIKit
// MARK: - Protocol
protocol MainViewModelType {
    func fetchAnswerByURL(completionSuccess: @escaping (String) -> Void, completionError: @escaping (MyError) -> Void)
    func increaseAndSaveTouches()
    func loadTouches () -> String
    func getAnimationAnswer() -> String
}
// MARK: - Class
class MainViewModel: MainViewModelType {
    private let mainModel: MainModelType
    init(mainModel: MainModelType) {
        self.mainModel = mainModel
    }
    func fetchAnswerByURL(completionSuccess: @escaping (String) -> Void,
                          completionError: @escaping (MyError) -> Void) {
        mainModel.fetchAnswerByURL { answer in
            completionSuccess(answer)
        } completionError: { error in
            completionError(error)
        }
    }
    func increaseAndSaveTouches() {
        mainModel.increaseTouches()
        mainModel.saveTouches()
    }
    func loadTouches () -> String {
        return String(mainModel.loadTouches())
    }
    func getAnimationAnswer() -> String {
        return AnswersForAnimation.answers.randomElement()!
    }
}
