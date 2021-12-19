//
//  MainCoordinator.swift
//  MagicEightBall
//
//  Created by Артём on 19.12.2021.
//

import UIKit

class MainCoordinator: NavigationNode {
    var storageManager: StorageServiceProtocol!
    var networkManager: NetworkServiceProtocol!
    var secureStorageService: SecureStorageServiceProtocol!
    weak var containerViewController: UIViewController?
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        addHandlers()
    }
    private func addHandlers() {}
}

extension MainCoordinator: FlowCoordinator {
    func createFlow() -> UIViewController {
        let mainModel = MainModel(networkManager: networkManager,
                                  storageManager: storageManager,
                                  secureStorageService: secureStorageService)
        let mainViewModel = MainViewModel(mainModel: mainModel)
        let mainViewController = MainViewController(viewModel: mainViewModel)
        containerViewController = mainViewController
        return mainViewController
    }
}
