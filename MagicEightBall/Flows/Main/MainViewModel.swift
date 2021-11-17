//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import UIKit

class MainViewModel: MainViewModelType {
    let mainModel: MainModelType
    lazy var completionHandler = self.mainModel.completionHandler
    init(mainModel: MainModelType = MainModel()) {
        self.mainModel = mainModel
    }
    func fetchAnswerByURL() -> String {
        let answer = mainModel.fetchAnswerByURL()
        return answer.uppercased()
    }
}
