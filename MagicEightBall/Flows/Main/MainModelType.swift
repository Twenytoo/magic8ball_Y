//
//  MainModelType.swift
//  MagicEightBall
//
//  Created by Артём on 17.11.2021.
//

import Foundation

protocol MainModelType {
    var countTouches: Int {get set}
    var answer: String! { get set }
    var networkManager: NetworkService { get set }
    var storageManager: StorageService { get set }
    var secureStorageService: SecureStorageServiceType { get set }
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL(completion: @escaping (_ answer: String?) -> Void)
    func saveTouches()
    func loadTouches () -> Int
    func increaseTouches()
}
