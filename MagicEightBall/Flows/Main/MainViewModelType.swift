//
//  MainViewModelType.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import UIKit

protocol MainViewModelType {
    var completionHandler: ((String) -> Void)? { get set }
    func fetchAnswerByURL(completion: @escaping (String) -> Void)
}
