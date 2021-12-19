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
    private let viewModel: HistoryViewModelType
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    init(viewModel: HistoryViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HistoryViewController {
    func setup() {
        title = L10n.history
        setTableView()
        setupBinding()
    }
    func setTableView() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        tableView.rowHeight = 44
        tableView.frame = view.bounds
        tableView.backgroundColor = .lightGray
        view.addSubview(tableView)
    }
    // MARK: - RX
    func setupBinding() {
        viewModel.answersRx
            .bind(to: tableView
                    .rx
                    .items(cellIdentifier: L10n.cell, cellType: CustomTableViewCell.self)) { _, answer, cell in
                cell.configureTextAnswer(text: answer)
            }.disposed(by: disposeBag)
    }
}
