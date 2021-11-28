//
//  Answer.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import Foundation

struct Answer {
    let text: String
    let date: Date
    init(text: String, date: Date) {
        self.text = text
        self.date = date
    }
}
