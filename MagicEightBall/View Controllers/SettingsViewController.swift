//
//  SettingsViewController.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit

class SettingsViewController: UITableViewController {

    
    let answers = ["Yes, definitely", "It is certain", "Without a doubt", "Yes", "Most likely", "Sure, why not?", "Same", "Tell me more", "Out to lunch", "Reply hazy, try again", "Ask again later", "The cake is a lie", "42", "TMI", "Very doubtful", "Don't count on it", "My reply is no", "Absolutely not"]


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
        
        answerCell.answerLabel?.text = answers[indexPath.row]
        
        return answerCell
        
    }
    
    //MARK: - Table view delegate
    


}
