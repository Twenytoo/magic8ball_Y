//
//  MainViewModelType.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import UIKit

protocol MainViewModelType {
    var networkManager: NetworkService { get set }
    var storageManager: StorageService { get set }
    var customView: CustomViewForMainVC { get }
    var settingNavigationVC: UINavigationController { get }
    func addButton() -> UIButton
}
