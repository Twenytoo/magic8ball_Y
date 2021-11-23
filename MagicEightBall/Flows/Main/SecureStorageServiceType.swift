//
//  SecureStorageServiceType.swift
//  MagicEightBall
//
//  Created by Артём on 22.11.2021.
//

import Foundation

protocol SecureStorageServiceType {
    func saveData (key: StorageKey, value: Any, dictionary: StorageDictionary)
    func updateData (key: StorageKey, value: Any, dictionary: StorageDictionary)
    func loadData (key: StorageKey, dictionary: StorageDictionary) -> Any?
}
