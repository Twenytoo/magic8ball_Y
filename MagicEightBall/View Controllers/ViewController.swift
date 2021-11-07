//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    // Array of objects of Answer type from database
    private var answers: Results<Answer>!
    
    //Entry point for working with network
    var networkManager: NetworkManager!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNetworkManager()
        networkManager.fetchAnswerByURL()
        
    }

    //Configuration the Shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        
        networkManager.completionHandler = { answer in self.updateAnswerLabel(answer: answer)}
        networkManager.fetchAnswerByURL()
        
        UIView.transition(with: answerLabel, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    ///Updates the label on the ViewController in the TableViewCell
    /// - Parameter answer:String
    /// - Returns: Void
    private func updateAnswerLabel(answer: String) {
        
        DispatchQueue.main.async {
            self.answerLabel.text = answer
        }
    }
    
    ///Returns the answer from database in case of unsuccessful internet connection
    ///
    ///Takes a random element from the database and turns it into string format. If the database is empty, it will inform the user that new answers need to be added.
    ///
    /// - Returns: Answer of String type
    func showAnswerWithoutConnection () -> String {
        
        answers = realm.objects(Answer.self)
        
        if let answer = answers?.randomElement()?.answerText {
            return answer
            
        } else {
            return "Add new answers"
        }
    }
    
    ///Сreates a NetworkManager instance and assigns the created instance to the networkManager class property
    private func setNetworkManager () {
        self.networkManager = NetworkManager()
    }
    
    //Action to cancel Settings ViewController
    @IBAction func cancelAction (_ segue: UIStoryboardSegue) {}
}


