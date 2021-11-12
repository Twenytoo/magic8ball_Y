//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    // Entry point for working with network
    var networkManager: NetworkService!
    var storageManager: StorageService!
    @IBOutlet weak var answerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // Configuration the Shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        networkManager.completionHandler = { answer in self.updateAnswerLabel(answer: answer)}
        networkManager.fetchAnswerByURL()
        UIView.transition(with: answerLabel,
                          duration: 0.5,
                          options: .transitionFlipFromTop,
                          animations: nil,
                          completion: nil)
    }
    /// Updates the label on the ViewController in the TableViewCell
    /// - Parameter answer:String
    /// - Returns: Void
    private func updateAnswerLabel(answer: String) {
        DispatchQueue.main.async {
            self.answerLabel.text = answer
        }
    }
    // Addtion dependencies
    func setNetworkManager(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    func setStorageManager(storageManager: StorageService) {
        self.storageManager = storageManager
    }
    // Passing storageManager to SetttingsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else {return}
        if let settingsVC = navigationVC.viewControllers.first as? SettingsViewController {
            settingsVC.storageManager = self.storageManager
        }
    }
    // Action to cancel Settings ViewController
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {}
}

// MARK: - Extension for Local DB
extension ViewController: DBService {
    /// Returns the answer from database in case of unsuccessful internet connection
    /// Takes a random element from the database and turns it into string format. If the database is empty.
    /// It will inform the user that new answers need to be added.
    ///
    /// - Returns: Answer of String type
    func showAnswerWithoutConnection() -> String {
        if let answer = storageManager.answers.randomElement()?.answerText {
            return answer
        } else {
            return L10n.add
        }
    }
}
