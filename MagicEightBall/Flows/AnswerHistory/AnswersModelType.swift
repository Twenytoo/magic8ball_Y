//
//  AnswersModelType.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation

protocol AnswersModelType {
    var answers: [Answer]! { get set }
    func getAllObejcts()
    var storageManager: StorageServiceProtocol { get set }
}
