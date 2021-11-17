//
//  DBService.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation

protocol DBService: AnyObject {
    func showAnswerWithoutConnection() -> String
}
