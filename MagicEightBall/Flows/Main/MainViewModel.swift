//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import UIKit

class MainViewModel: MainViewModelType {
    private let mainModel: MainModelType
    lazy var completionHandler = self.mainModel.completionHandler
    init(mainModel: MainModelType = MainModel()) {
        self.mainModel = mainModel
    }
    func fetchAnswerByURL(completion: @escaping (String) -> Void) {
        mainModel.fetchAnswerByURL { answer in
            let answerString = answer!.uppercased()
            completion(answerString)
        }
    }
}
