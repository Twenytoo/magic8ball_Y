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
        let mainViewModel = MainViewModel(networkManager: networkManager,
                                          storageManager: storageManager,
                                          customView: customView)
//        let mainNavigationVC = MainNavigationViewController()
        let mainVC = MainViewController(viewModel: mainViewModel)
//        let settingsVC = SettingsViewController(storageManager: storageManager)
//        mainNavigationVC.viewControllers = [mainVC]
        storageManager.answers = realm.objects(Answer.self)
        mainVC.networkManager.dataBaseDelegate = mainVC

        window.rootViewController = mainVC
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
//    // MARK: UISceneSession Lifecycle
//    func application(_ application: UIApplication,
//                     configurationForConnecting connectingSceneSession: UISceneSession,
//                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running,
//        // this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
}
