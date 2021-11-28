//
//  TableViewController.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import UIKit
import CoreData

class HistoryViewController: UITableViewController {
    let answerViewModel: AnswerViewModelType

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    init(answerViewModel: AnswerViewModelType) {
        self.answerViewModel = answerViewModel
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
        var count = 0
            answerViewModel.getAnswerFromEntity { answers in
                count = answers.count
        }
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.cell, for: indexPath)
        guard let answerCell = cell as? CustomTableViewCell else {return UITableViewCell()}
        answerCell.configureTextAnswer(text: answerViewModel.getTextOfAnswer(indexPath: indexPath.row))
        answerCell.configureTextDate(text: answerViewModel.getDateOfAnswer(indexPath: indexPath.row))
        return answerCell
    }
    func setTableView() {
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        title = L10n.history
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        tableView.rowHeight = 44
    }
}
