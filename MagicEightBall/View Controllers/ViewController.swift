//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var networkManager = NetworkManager()
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var shakeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchAnswer()
    }
    
    @IBAction func shakeButtonTapped(_ sender: UIButton) {
        shakeButton.setTitle("I said SHAKE IT!", for: .normal)
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
}


