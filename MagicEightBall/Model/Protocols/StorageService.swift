//
//  StorageService.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation
import RealmSwift

protocol StorageService {
    var answers: Results<Answer>! { get set}
    func saveObject (_ answer: Answer)
    func deleteObject (_ answer: Answer)
}
