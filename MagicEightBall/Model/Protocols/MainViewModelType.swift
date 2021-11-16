//
//  MainViewModelType.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation

protocol MainViewModelType {
    var networkManager: NetworkService { get }
    var storageManager: StorageService { get }
    var customView: CustomViewForMainVC { get }
}
