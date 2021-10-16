//
//  AnswerModel.swift
//  MagicEightBall
//
//  Created by Артём on 16.10.2021.
//

import Foundation

struct Answer {
    
    var answerText: String
    
    static let hardcodedAnswers = ["Yes, definitely", "It is certain", "Without a doubt", "Yes", "Most likely", "Sure, why not?", "Same", "Tell me more", "Out to lunch", "Reply hazy, try again", "Ask again later", "The cake is a lie", "42", "TMI", "Very doubtful", "Don't count on it", "My reply is no", "Absolutely not"]
    
    static func getAnswers () -> [Answer] {
        
        var answers = [Answer] ()
        
        for answer in hardcodedAnswers {
            answers.append(Answer(answerText: answer))
        }
        
        
        return answers
    }
}
 




