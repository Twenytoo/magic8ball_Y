//
//  SettingsViewController.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit

class SettingsViewController: UITableViewController {

    var answers = Answer.getAnswers()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return answers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  answerCell = tableView.dequeueReusableCell(withIdentifier: "Answer", for: indexPath) as! CustomTableViewCell
        
        answerCell.answerLabel?.text = answers[indexPath.row].answerText
        
        return answerCell
        
    }
    
    //MARK: - Table view delegate
    
}
