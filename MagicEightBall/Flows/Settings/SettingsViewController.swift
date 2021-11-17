//
//  SettingsViewController.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit
import RealmSwift

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    SettingViewModel
    let viewModel: SettingsViewModelType
//    Creating table view
        let tableView: UITableView = {
        let tableView = UITableView()
            tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        return tableView
    }()
//    var message: String!
    init(viewModel: SettingsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addAnswerByBarButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .checkmark,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissSelf(_:)))
        view.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.dataSource = self
        tableView.frame = view.bounds
        title = L10n.settings
    }
    // MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.storageManager.answers.isEmpty ? 0 : viewModel.storageManager.answers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.cell, for: indexPath)
        guard let answerCell = cell as? CustomTableViewCell else {return UITableViewCell()}
        answerCell.configure(text: viewModel.storageManager.answers[indexPath.row].answerText)
        return answerCell
    }
    // MARK: - Table view delegate
     func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        let answer = viewModel.storageManager.answers[indexPath.row]
        let deleteItem = UIContextualAction(style: .destructive, title: L10n.delete) {  (_, _, _) in
            self.viewModel.storageManager.deleteObject(answer)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let deleteAction = UISwipeActionsConfiguration(actions: [deleteItem])
        return deleteAction
    }
    // Calls the alert to create a new answer on pressing a BarButton
    @objc func addAnswerByBarButton() {
        let addAnswer = UIAlertController(title: L10n.add, message: nil, preferredStyle: .alert)
        addAnswer.addTextField { (textField) in textField.placeholder = L10n.enter
        }
        let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel) { _ in }
        addAnswer.addAction(cancelAction)
        let doneAction = UIAlertAction(title: L10n.done, style: .default) { _ in
            if let addAnswerTextField = addAnswer.textFields?[0].text {
                self.viewModel.addNewAnswer(answer: addAnswerTextField)
                self.tableView.reloadData()
            }
        }
        addAnswer.addAction(doneAction)
        present(addAnswer, animated: true)
    }
    @objc func dismissSelf(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
