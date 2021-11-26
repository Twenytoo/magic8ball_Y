//
//  SettingsModelType.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation
import RealmSwift

protocol SettingsModelType {
    var answers: [String]? { get set }
    var storageManager: StorageServiceProtocol { get set }
    func addNewAnswer(answer: String)
    func deleteAnswer(answer: String)
}
