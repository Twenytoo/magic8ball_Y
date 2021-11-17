//
//  MainModelType.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation

protocol MainModelType {
    var networkManager: NetworkService { get set }
    var storageManager: StorageService { get set }
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL() -> String
}
