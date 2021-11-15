//
//  File.swift
//  MagicEightBall
//
//  Created by Артём on 15.11.2021.
//

import Foundation

protocol MainViewModelType {
    var networkManager: NetworkService { get set }
    var storageManager: StorageService { get set }
    var customView: CustomViewForMainVC { get set }
}
