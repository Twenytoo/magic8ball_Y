//
//  NetworkService.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation

protocol NetworkService {
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL() -> String
    func parseJSON(withData data: Data ) -> String?
}
