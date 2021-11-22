//
//  SecureStorage.swift
//  MagicEightBall
//
//  Created by Артём on 22.11.2021.
//

import Foundation
import Locksmith

class SecureStorageService: SecureStorageServiceType {
    var countTouches = 0
    func saveData () {
        do {
            try Locksmith.saveData(data: ["touches": countTouches], forUserAccount: "count_of_touches")
        } catch {
            print("Unable to save – ", error)
        }
    }
    func updateData () {
        do {
            try Locksmith.updateData(data: ["touches": countTouches], forUserAccount: "count_of_touches")
        } catch {
            print("Unable to update – ", error)
        }
    }
    func saveTouches() {
        if countTouches == 1 {
            saveData()
        } else {
            updateData()
        }
    }
    func loadTouches () {
        guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: "count_of_touches") else { return }
        self.countTouches = dictionary["touches"] as? Int ?? 0
    }
}
