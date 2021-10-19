//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var answers: Results<Answer>!
    
    var networkManager = NetworkManager()
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchAnswer()
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        networkManager.completionHandler = { answer in self.updateAnswerLabel(answer: answer)}
        networkManager.fetchAnswer()
        UIView.transition(with: answerLabel, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    func updateAnswerLabel(answer: String) {
        DispatchQueue.main.async {
            self.answerLabel.text = answer
        }
    }
    
    func showAnswerWithoutConnection () -> String {
        answers = realm.objects(Answer.self)
        if let answer = answers?.randomElement()?.answerText {
            return answer
        } else {
        return "Add new answers"
        }
    }
    
    @IBAction func cancelAction (_ segue: UIStoryboardSegue) {}
}


