//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import UIKit

class MainViewModel: MainViewModelType, DBService {
//    var settingsVC: SettingViewModel
    var networkManager: NetworkService
    var storageManager: StorageService
    let customView: CustomViewForMainVC
    var settingNavigationVC: UINavigationController
    init(networkManager: NetworkService,
         storageManager: StorageService,
         customView: CustomViewForMainVC,
         settingNavigationVC: UINavigationController) {
        self.networkManager = networkManager
        self.storageManager = storageManager
        self.customView = customView
        self.settingNavigationVC = settingNavigationVC
    }
    func addButton() -> UIButton {
        let settingsButton = UIButton(frame: CGRect(x: 115, y: 500, width: 200, height: 100))
        settingsButton.setTitleColor(.cyan, for: .normal)
        settingsButton.setTitle(L10n.settings, for: .normal)
        settingsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        settingsButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return settingsButton
    }
    @objc func buttonDidTap(closure: () -> Void) {
//        self.settingsVC.viewModel.storageManager = self.storageManager
////        let mainNavigationVC = MainNavigationViewController(rootViewController: settingsVC)
//        present(mainNavigationVC, animated: true)
        print("SOMETHING!!!")
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
