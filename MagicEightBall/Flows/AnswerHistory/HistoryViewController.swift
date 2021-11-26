//
//  TableViewController.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import UIKit

class AnswersHistory: UITableViewController {
    let answerViewModel: AnswerViewModelType

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta

    }
    init(answerViewModel: AnswerViewModelType) {
        self.answerViewModel = answerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.answerViewModel.getAnswers()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return answerViewModel.answers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "historyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = "\(answerViewModel.answers[indexPath.row].text) \(answerViewModel.answers[indexPath.row].date)"
        return cell
    }
}
