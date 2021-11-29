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
        //        AnswersHistory View Controller
        let storageManager = StorageManager()
        let answerModel = AnswersModel(storagemanager: storageManager)
        let answerViewModel = AnswerViewModel(answerModel: answerModel)
        let answerHistoryVC = HistoryViewController(answerViewModel: answerViewModel)
        let answerHistoryNavVC = UINavigationController(rootViewController: answerHistoryVC)
        answerHistoryNavVC.title = L10n.history
        //        Setttings View Controller
        let settingsModel = SettingsModel(storageManager: storageManager)
        let settingViewModel = SettingViewModel(settingsModel: settingsModel)
        let settingsVC = SettingsViewController(viewModel: settingViewModel)
        let settingsNavVC = UINavigationController(rootViewController: settingsVC)
        settingsNavVC.title = L10n.settings
        //        Managers
        let getAnswerWithoutConnectionManager = GetAnswerWithoutConnection(storageManager: storageManager)
        let networkManager = NetworkManager(createAnswerManager: settingsModel,
                                            getAnswerWithoutConnectionManager: getAnswerWithoutConnectionManager)
        let secureStorageService = SecureStorageService()
        //        Main View Controller
        let mainModel = MainModel(networkManager: networkManager,
                                  storageManager: storageManager,
                                  secureStorageService: secureStorageService)
        let mainViewModel = MainViewModel(mainModel: mainModel)
        let mainVC = MainViewController(viewModel: mainViewModel)
        let mainNavVC = UINavigationController(rootViewController: mainVC)
        mainNavVC.title = L10n.main
        //        TabBar View Controller
        let tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers([mainNavVC, settingsNavVC, answerHistoryNavVC],
                                                animated: true)
        tabBarViewController.modalPresentationStyle = .fullScreen
        //        Window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarViewController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
