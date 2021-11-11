//
//  SceneDelegate.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let mainVC = UIStoryboard(name: "Main",
                                        bundle: nil).instantiateViewController(withIdentifier: "ViewController")
                                        as? ViewController else {return}
        let networkManager = NetworkManager()
        let storageManager = StorageManager()
        storageManager.answers = realm.objects(Answer.self)
        mainVC.setNetworkManager(networkManager: networkManager)
        mainVC.setStorageManager(storageManager: storageManager)
        mainVC.networkManager.dataBaseDelegate = mainVC
        self.window?.rootViewController = mainVC
    }
}
