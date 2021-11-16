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
        let customView = CustomViewForMainVC()
        let settingViewModel = SettingViewModel(storageManager: storageManager)
        let settingsVC = SettingsViewController(viewModel: settingViewModel)
        let settingNavigationVC = UINavigationController()
        let mainViewModel = MainViewModel(networkManager: networkManager,
                                          storageManager: storageManager,
                                          customView: customView,
                                          settingNavigationVC: settingNavigationVC,
                                          settingController: settingsVC)
        let mainVC = MainViewController(viewModel: mainViewModel)
//        mainNavigationVC.viewControllers = [mainVC]
        storageManager.answers = realm.objects(Answer.self)
        mainViewModel.networkManager.dataBaseDelegate = mainViewModel

        window.rootViewController = mainVC
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
