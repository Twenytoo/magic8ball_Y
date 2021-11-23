//
//  SecureStorage.swift
//  MagicEightBall
//
//  Created by Артём on 22.11.2021.
//

import Foundation
import Locksmith

enum StorageKey: String {
    case keyForTouches = "touches"
}
enum StorageDictionary: String {
    case countOfTouches = "count_of_touches"
}

class SecureStorageService: SecureStorageServiceType {
    func saveData (key: StorageKey, value: Any, dictionary: StorageDictionary) {
        do {
            try Locksmith.saveData(data: [key.rawValue: value], forUserAccount: dictionary.rawValue)
        } catch {
            print("Unable to save – ", error)
        }
    }
    func updateData (key: StorageKey, value: Any, dictionary: StorageDictionary) {
        do {
            try Locksmith.updateData(data: [key.rawValue: value], forUserAccount: dictionary.rawValue)
        } catch {
            print("Unable to update – ", error)
        }
    }
    func loadData (key: StorageKey, dictionary: StorageDictionary) -> Any? {
        guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: dictionary.rawValue) else { return nil}
        return dictionary[key.rawValue]
    }
}
