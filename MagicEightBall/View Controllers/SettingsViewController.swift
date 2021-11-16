//
//  SettingsViewController.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit
import RealmSwift

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        let tableView: UITableView = {
        let tableView = UITableView()
            tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        return tableView
    }()
    // Array of objects of Answer type from database
    var storageManager: StorageService
    var message: String!
    init(storageManager: StorageService) {
        self.storageManager = storageManager
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
                                                            action:  #selector(addAnswerByBarButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .checkmark,
                                                           style: .plain,
                                                           target: self,
                                                           action:  #selector(dismissSelf(_:)))
        view.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.dataSource = self
        tableView.frame = view.bounds
        title = L10n.settings
    }
    /// Adds the new object of Answer type in the database
    /// Creates an instance of Answer type from String type.
    /// Then pass the object of Answer type to store it in the database
    ///
    /// - Parameter answer: Sting
    /// - Returns: Void
    private func addNewAnswer(answer: String) {
        let newAnswer = Answer(name: answer)
        storageManager.saveObject(newAnswer)
    }
    // MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storageManager.answers.isEmpty ? 0 : storageManager.answers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.cell, for: indexPath)
        guard let answerCell = cell as? CustomTableViewCell else {return UITableViewCell()}
        answerCell.configure(text: storageManager.answers[indexPath.row].answerText)
        return answerCell
    }
    // MARK: - Table view delegate
     func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        let answer = storageManager.answers[indexPath.row]
        let deleteItem = UIContextualAction(style: .destructive, title: L10n.delete) {  (_, _, _) in
            self.storageManager.deleteObject(answer)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let deleteAction = UISwipeActionsConfiguration(actions: [deleteItem])
        return deleteAction
    }
    // Calls the alert to create a new answer on pressing a BarButton
    @objc func addAnswerByBarButton(_ sender: UIBarButtonItem) {
        let addAnswer = UIAlertController(title: L10n.add, message: nil, preferredStyle: .alert)
        addAnswer.addTextField { (textField) in textField.placeholder = L10n.enter
        }
        let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel) { _ in }
        addAnswer.addAction(cancelAction)
        let doneAction = UIAlertAction(title: L10n.done, style: .default) { _ in
            if let addAnswerTextField = addAnswer.textFields?[0].text {
                self.addNewAnswer(answer: addAnswerTextField)
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
