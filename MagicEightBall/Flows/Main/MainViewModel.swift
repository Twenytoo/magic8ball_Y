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
    func fetchAnswerByURL(completionSuccess: @escaping (String) -> Void, completionError: @escaping (MyError) -> Void)
    func increaseAndSaveTouches()
    func loadTouches ()
    func getAnimationAnswer() -> String
    //rx
    var countTouchesRX: Observable<Int> { get }
}
// MARK: - Class
class MainViewModel: MainViewModelType {
    //    RX
    var countTouchesRX: Observable<Int> {
        mainModel.countTouchesRX
    }
    //OLD
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
    func loadTouches () {
        mainModel.loadTouches()
    }
    func getAnimationAnswer() -> String {
        return AnswersForAnimation.answers.randomElement()!
    }
}
//MARK: -RX
extension MainViewModel {
    
}
