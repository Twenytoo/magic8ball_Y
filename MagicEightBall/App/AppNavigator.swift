//
//  AppNavigator.swift
//  MagicEightBall
//
//  Created by Артём on 19.12.2021.
//

import UIKit

final class AppNavigator: NavigationNode {
    private let window: UIWindow
    private let storageManager: StorageServiceProtocol
    private let networkManager: NetworkServiceProtocol
    private let secureStorageService: SecureStorageServiceProtocol
    init(window: UIWindow) {
        self.window = window
        let storageManager = StorageManager()
        self.storageManager = storageManager
        self.networkManager = NetworkManager(createAnswerManager: storageManager,
                                             getAnswerWithoutConnectionManager: storageManager)
        self.secureStorageService = SecureStorageService()
        super.init(parent: nil)
    }
    func startFlow() {
        let coordinator = TabBarCoordinator(parent: self,
                                            storageManager: storageManager,
                                            networkManager: networkManager,
                                            secureStorageService: secureStorageService)
        let controller = coordinator.createFlow()
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
