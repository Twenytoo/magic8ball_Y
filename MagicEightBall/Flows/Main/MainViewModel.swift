//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import UIKit
// MARK: - Protocol
protocol MainViewModelType {
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL(completion: @escaping (String) -> Void)
    func increaseAndSaveTouches()
    func loadTouches () -> String
}
// MARK: - Class
class MainViewModel: MainViewModelType {
    private let mainModel: MainModelType
    lazy var completionHandler = self.mainModel.completionHandler
    init(mainModel: MainModelType) {
        self.mainModel = mainModel
    }
    func fetchAnswerByURL(completion: @escaping (String) -> Void) {
        mainModel.fetchAnswerByURL { answer in
            let answerString = answer!.uppercased()
            completion(answerString)
        }
    }
    func increaseAndSaveTouches() {
        mainModel.increaseTouches()
        mainModel.saveTouches()
    }
    func loadTouches () -> String {
        return String(mainModel.loadTouches())
    }
}
