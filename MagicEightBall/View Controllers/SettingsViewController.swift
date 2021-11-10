//
//  SettingsViewController.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit
import RealmSwift

class SettingsViewController: UITableViewController {
    
    // Array of objects of Answer type from database
    var storageManager: StorageService!
    
    var message: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    ///Adds the new object of Answer type in the database
    ///
    ///
    /// Creates an instance of Answer type from String type. Then pass the object of Answer type to store it in the database
    ///
    /// - Parameter answer: Sting
    /// - Returns: Void
    private func addNewAnswer (answer: String) -> () {
        
        let newAnswer = Answer(name: answer)
        
        storageManager.saveObject(newAnswer)
        
    }

    
    //MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return storageManager.answers.isEmpty ? 0 : storageManager.answers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  answerCell = tableView.dequeueReusableCell(withIdentifier: "Answer", for: indexPath) as! CustomTableViewCell
        
        answerCell.answerLabel?.text = storageManager.answers[indexPath.row].answerText
        
        return answerCell
        
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let answer = storageManager.answers[indexPath.row]
        
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {  (_,_,_) in
            self.storageManager.deleteObject(answer)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let deleteAction = UISwipeActionsConfiguration(actions: [deleteItem])
        
        return deleteAction
    }
    
    //Calls the alert to create a new answer on pressing a BarButton
    @IBAction func addAnswerByBarButton(_ sender: UIBarButtonItem) {
        
        let addAnswer = UIAlertController(title: "Add your answer", message: nil, preferredStyle: .alert)
        
        addAnswer.addTextField { (textField) in textField.placeholder = "Enter your answer"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        addAnswer.addAction(cancelAction)
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            
            if let addAnswerTextField = addAnswer.textFields?[0].text {
                self.addNewAnswer(answer: addAnswerTextField)
                self.tableView.reloadData()
            }
        }
        addAnswer.addAction(doneAction)
        
        present(addAnswer, animated: true)
    }
}
