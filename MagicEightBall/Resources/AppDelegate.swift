//
//  AppDelegate.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let networkManager = NetworkManager()
        let storageManager = StorageManager()
        let secureStorageService = SecureStorageService()
        let mainModel = MainModel(networkManager: networkManager,
                                  storageManager: storageManager,
                                  secureStorageService: secureStorageService)
        let mainViewModel = MainViewModel(mainModel: mainModel)
        let mainVC = MainViewController(viewModel: mainViewModel)
        storageManager.answers = realm.objects(Answer.self)
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
