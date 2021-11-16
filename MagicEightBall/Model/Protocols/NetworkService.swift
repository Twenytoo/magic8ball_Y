//
//  NetworkService.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation

// Manager for working with network
protocol NetworkService {
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL()
    func parseJSON(withData data: Data ) -> String?
    var dataBaseDelegate: DBService! { get set }
}
