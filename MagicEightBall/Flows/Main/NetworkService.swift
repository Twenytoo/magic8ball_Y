//
//  NetworkService.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation

protocol NetworkService {
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL(completion: @escaping (_ answer: String?) -> Void)
    func parseJSON(withData data: Data ) -> String?
}
