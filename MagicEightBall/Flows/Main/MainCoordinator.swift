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
    init(   parent: NavigationNode?,
            storageManager: StorageServiceProtocol,
            networkManager: NetworkServiceProtocol,
            secureStorageService: SecureStorageServiceProtocol) {
        self.storageManager = storageManager
        self.networkManager = networkManager
        self.secureStorageService = secureStorageService
        super.init(parent: parent)
    }
    deinit {
        print("MainCoordinator deinit")
    }
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
