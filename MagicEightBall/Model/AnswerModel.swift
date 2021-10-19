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
    
    let hardcodedAnswers = ["It is certain", "Without a doubt", "Yes", "Most likely", "Sure, why not?", "Same", "Ask again later", "42", "TMI", "Very doubtful", "Don't count on it", "My reply is no", "Absolutely not"]
    
    func saveAnswers () {

        for answer in hardcodedAnswers {
                
            let newAnswer = Answer()
            
            newAnswer.answerText = answer
            
            StorageManager.saveObject(newAnswer)
        }
    }
}
 




