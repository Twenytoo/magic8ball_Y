//
//  MainViewModel.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import UIKit

class MainViewModel: MainViewModelType {
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
}
