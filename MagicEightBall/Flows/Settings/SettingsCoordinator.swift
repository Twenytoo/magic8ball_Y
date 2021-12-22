//
//  SettingsCoordinator.swift
//  MagicEightBall
//
//  Created by Артём on 19.12.2021.
//

import UIKit

class SettingsCoordinator: NavigationNode {
    var storageManager: StorageServiceProtocol
    weak var containerViewController: UIViewController?
    init(   parent: NavigationNode?,
            storageManager: StorageServiceProtocol) {
        self.storageManager = storageManager
        super.init(parent: parent)
    }
    deinit {
        print("SettingsCoordinator deinit")
    }
}

extension SettingsCoordinator: FlowCoordinator {
    func createFlow() -> UIViewController {
        let settingsModel = SettingsModel(storageManager: storageManager)
        let settingsViewModel = SettingViewModel(model: settingsModel)
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        containerViewController = settingsViewController
        return settingsViewController
    }
}
