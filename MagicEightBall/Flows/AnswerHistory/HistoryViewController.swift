//
//  TableViewController.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import UIKit

class AnswersHistory: UITableViewController {
    let viewModel: AnswerViewModelType

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        title = L10n.history
        tableView.rowHeight = 44

    }
    init(answerViewModel: AnswerViewModelType) {
        self.viewModel = answerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.answers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.cell, for: indexPath)
        guard let answerCell = cell as? CustomTableViewCell else {return UITableViewCell()}
        answerCell.configureTextAnswer(text: viewModel.answers[indexPath.row].text)
        answerCell.configureTextDate(text: viewModel.getDateByString(indexPath: indexPath.row))
        return answerCell
    }
}
