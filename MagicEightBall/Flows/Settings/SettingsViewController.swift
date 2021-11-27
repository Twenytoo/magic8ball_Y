//
//  SettingsViewController.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //    SettingViewModel
    private var settingsViewModel: SettingsViewModelType
    private var answerViewModel: AnswerViewModelType
    //    Creating table view
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        return tableView
    }()
    init(viewModel: SettingsViewModelType, answerViewModel: AnswerViewModelType) {
        self.settingsViewModel = viewModel
        self.answerViewModel = answerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        addBarButtonItems()
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.answers.isEmpty ? 0 : settingsViewModel.answers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.cell, for: indexPath)
        guard let answerCell = cell as? CustomTableViewCell else {return UITableViewCell()}
        answerCell.configureTextAnswer(text: settingsViewModel.answers[indexPath.row])
        return answerCell
    }
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        let answer = settingsViewModel.answers[indexPath.row]
        let deleteItem = UIContextualAction(style: .destructive, title: L10n.delete) {  (_, _, _) in
            self.settingsViewModel.deleteAnswer(answer: answer)
            self.settingsViewModel.answers.remove(at: indexPath.row)
            self.answerViewModel.deleteAnswer(text: answer)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let deleteAction = UISwipeActionsConfiguration(actions: [deleteItem])
        return deleteAction
    }
    /// Calls the alert to create a new answer on pressing a BarButton
    @objc private func addAnswerByBarButton() {
        let addAnswer = UIAlertController(title: L10n.add, message: nil, preferredStyle: .alert)
        addAnswer.addTextField { (textField) in textField.placeholder = L10n.enter
        }
        let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel) { _ in }
        addAnswer.addAction(cancelAction)
        let doneAction = UIAlertAction(title: L10n.done, style: .default) { _ in
            if let addAnswerTextField = addAnswer.textFields?[0].text {
                self.settingsViewModel.answers.append(addAnswerTextField)
                self.answerViewModel.addAnswer(answer: addAnswerTextField)
                self.settingsViewModel.addNewAnswer(answer: addAnswerTextField)
                self.tableView.reloadData()
            }
        }
        addAnswer.addAction(doneAction)
        present(addAnswer, animated: true)
    }
}

private extension SettingsViewController {
    func addBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addAnswerByBarButton))
    }
    func setTableView() {
        title = L10n.settings
        tableView.rowHeight = 44
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .lightGray
        view.addSubview(tableView)
    }
}
