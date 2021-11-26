//
//  DBService.swift
//  MagicEightBall
//
//  Created by Артём on 16.11.2021.
//

import Foundation

protocol GetAnswerFromDBProtocol: AnyObject {
    func showAnswerWithoutConnection() -> String
}
