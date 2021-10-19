//
//  SettingsViewController.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit
import RealmSwift

class SettingsViewController: UITableViewController {

    var answers: Results<Answer>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answers = realm.objects(Answer.self)
    }
    
    func addNewAnswer (answer: String) -> () {
        
        let newAnswer = Answer(name: answer)
        
        StorageManager.saveObject(newAnswer)
       
    }

    @IBAction func cancelByBarButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return answers.isEmpty ? 0 : answers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let  answerCell = tableView.dequeueReusableCell(withIdentifier: "Answer", for: indexPath) as! CustomTableViewCell

        answerCell.answerLabel?.text = answers[indexPath.row].answerText

        return answerCell

    }
    
    //MARK: - Table view delegate
    
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
