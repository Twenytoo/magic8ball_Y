//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import UIKit

class MainViewModel: MainViewModelType, DBService {
    func addButton() -> UIButton {
        return UIButton()
    }
    var networkManager: NetworkService
    var storageManager: StorageService
    let customView: CustomViewForMainVC
    init(networkManager: NetworkService,
         storageManager: StorageService,
         customView: CustomViewForMainVC) {
        self.networkManager = networkManager
        self.storageManager = storageManager
        self.customView = customView
    }

    /// Returns the answer from database in case of unsuccessful internet connection
    /// Takes a random element from the database and turns it into string format. If the database is empty.
    /// It will inform the user that new answers need to be added.
    ///
    /// - Returns: Answer of String type
    func showAnswerWithoutConnection() -> String {
        if let answer = storageManager.answers.randomElement()?.answerText {
            return answer
        } else {
            return L10n.add
        }
    }
}
