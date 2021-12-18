//
//  SettingsViewController.swift
//  MagicEightBall
//
//  Created by Артём on 14.10.2021.
//

import UIKit
import RxSwift
import RxCocoa
class SettingsViewController: UIViewController, UITableViewDelegate {
    private var settingsViewModel: SettingsViewModelType
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    init(viewModel: SettingsViewModelType) {
        self.settingsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        settingsViewModel.getAnswersFromDBRX()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: L10n.delete, style: .destructive) { _ in
            self.settingsViewModel.deleteAnswerAt(indexPath: indexPath.row)
        })
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(sheet, animated: true, completion: nil)
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
                self.settingsViewModel.addNewAnswer(answer: addAnswerTextField)
            }
        }
        addAnswer.addAction(doneAction)
        present(addAnswer, animated: true)
    }
}
// MARK: - SETUP
private extension SettingsViewController {
    func setup() {
        title = L10n.settings
        addBarButtonItems()
        setTableView()
        setupBinding()
    }
    func addBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addAnswerByBarButton))
    }
    func setTableView() {
        tableView.rowHeight = 44
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.backgroundColor = .lightGray
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: L10n.cell)
        view.addSubview(tableView)
    }
    // MARK: - Binding
    func setupBinding() {
        settingsViewModel.answersRx
            .bind(to: tableView
                    .rx
                    .items(cellIdentifier: L10n.cell, cellType: CustomTableViewCell.self)) { _, answer, cell in
                cell.configureTextAnswer(text: answer)
            }.disposed(by: disposeBag)
    }
}
