//
//  DecodedData.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit

struct DecodedData: Codable {
    let magic: Magic
}

struct Magic: Codable {
    let question: String
    let answer: String
    let type: String
}
