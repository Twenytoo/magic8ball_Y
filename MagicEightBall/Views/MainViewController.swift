//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    var viewModel: MainViewModelType
//     Entry point for working with network
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(viewModel.customView)
        self.view.addSubview(addButton())
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.customView.frame = view.bounds
    }
//     Configuration the Shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        viewModel.networkManager.completionHandler = { answer in self.updateAnswerLabel(answer: answer)}
        viewModel.networkManager.fetchAnswerByURL()
        UIView.transition(with: viewModel.customView.answerLabel,
                          duration: 0.5,
                          options: .transitionFlipFromTop,
                          animations: nil,
                          completion: nil)
    }
    /// Updates the label on the ViewController in the TableViewCell
    /// - Parameter answer:String
    /// - Returns: Void
    private func updateAnswerLabel(answer: String) {
        DispatchQueue.main.async {
            self.viewModel.customView.answerLabel.text = answer.uppercased()
        }
    }
    func addButton() -> UIButton {
        let settingsButton = UIButton(frame: CGRect(x: 115, y: 500, width: 200, height: 100))
        settingsButton.setTitleColor(.cyan, for: .normal)
        settingsButton.setTitle(L10n.settings, for: .normal)
        settingsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        settingsButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return settingsButton
    }
    @objc func buttonDidTap() {
        let settingViewModel = SettingViewModel(storageManager: viewModel.storageManager)
        let setVC = SettingsViewController(viewModel: settingViewModel)
        present(UINavigationController(rootViewController: setVC), animated: true)
    }
}
