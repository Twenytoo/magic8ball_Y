//
//  TableViewController.swift
//  MagicEightBall
//
//  Created by Артём on 26.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController {
    private let answerViewModel: AnswerViewModelType
    private let disposeBag = DisposeBag()
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setupBinding()
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

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return answerViewModel.getCountOfAnswers()
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.cell, for: indexPath)
//        guard let answerCell = cell as? CustomTableViewCell else {return UITableViewCell()}
//        answerCell.configureTextAnswer(text: answerViewModel.getTextOfAnswer(indexPath: indexPath.row))
//        answerCell.configureTextDate(text: answerViewModel.getDateOfAnswer(indexPath: indexPath.row))
//        return answerCell
//    }
    // MARK: - RX
    func setupBinding() {
        answerViewModel.answersRx
            .bind(to: tableView.rx.items(cellIdentifier: L10n.cell, cellType: CustomTableViewCell.self)) { row, answer, cell in
                cell.configureTextAnswer(text: answer)
            }.disposed(by: disposeBag)
    }
}

private extension HistoryViewController {
    func setTableView() {
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        title = L10n.history
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        tableView.rowHeight = 44
        tableView.frame = view.bounds
        tableView.backgroundColor = .lightGray
        view.addSubview(tableView)
    }
}
