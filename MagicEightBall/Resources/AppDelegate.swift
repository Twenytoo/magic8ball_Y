//
//  AppDelegate.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        AnswersHistory View Controller
        let storageManager = StorageManager()
        let answerModel = AnswersModel(storagemanager: storageManager)
        let answerViewModel = AnswerViewModel(answerModel: answerModel)
        let answerHistoryVC = AnswersHistory(answerViewModel: answerViewModel)
        let answerHistoryNavVC = UINavigationController(rootViewController: answerHistoryVC)
        answerHistoryNavVC.title = L10n.history
        //        Setttings View Controller
        let settingsModel = SettingsModel(storageManager: storageManager)
        let settingViewModel = SettingViewModel(settingsModel: settingsModel)
        let settingsVC = SettingsViewController(viewModel: settingViewModel, answerViewModel: answerViewModel)
        let settingsNavVC = UINavigationController(rootViewController: settingsVC)
        settingsNavVC.title = L10n.settings
        //        Managers
        let networkManager = NetworkManager(dbManager: storageManager,
                                            answerViewModel: answerViewModel,
                                            settingViewModel: settingViewModel)
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
    // MARK: - Core Data stack
    static let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Answers")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
