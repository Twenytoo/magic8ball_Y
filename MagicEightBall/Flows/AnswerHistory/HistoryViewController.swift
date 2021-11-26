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
        title = L10n.history

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
        return answerViewModel.answers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.cell, for: indexPath)
        guard let answerCell = cell as? CustomTableViewCell else {return UITableViewCell()}
        answerCell.configureTextAnswer(text: answerViewModel.answers[indexPath.row].text)
        answerCell.configureTextDate(text: answerViewModel.answers[indexPath.row].date)
        return answerCell
    }
}
