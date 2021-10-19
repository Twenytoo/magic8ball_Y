//
//  AnswerModel.swift
//  MagicEightBall
//
//  Created by Артём on 16.10.2021.
//

import UIKit
import RealmSwift

class Answer: Object {
    
    @objc dynamic var answerText = ""
    
    convenience init (name: String) {
        self.init()
        self.answerText = name
    }
}
 




