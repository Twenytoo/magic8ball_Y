//
//  SecureStorageServiceType.swift
//  MagicEightBall
//
//  Created by Артём on 22.11.2021.
//

import Foundation

protocol SecureStorageServiceType {
    var countTouches: Int {get set}
    func saveData ()
    func updateData ()
    func saveTouches ()
    func loadTouches ()
}
