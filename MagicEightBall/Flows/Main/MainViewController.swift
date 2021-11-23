//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import SnapKit
import RealmSwift

class MainViewController: UIViewController {
    private let answerLabel = UILabel()
    private let countLabel = UILabel()
    private let imageBallView = UIImageView()
    private let settingsButton = UIButton()
    private var viewModel: MainViewModelType
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInterface()
        setupConstraints()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        viewModel.increaseAndSaveTouches()
        DispatchQueue.main.async {
            self.setupCounLabel()
        }
        viewModel.fetchAnswerByURL {answer in
            DispatchQueue.main.async {
                self.updateAnswerLabel(answer: answer)
            }
        }
        UIView.transition(with: self.answerLabel,
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
            self.answerLabel.text = answer
        }
    }
    @objc private func buttonDidTap() {
        let storageManager = StorageManager()
        let settingsModel = SettingsModel(storageManager: storageManager)
        let settingViewModel = SettingViewModel(settingsModel: settingsModel)
        let settingsVC = SettingsViewController(viewModel: settingViewModel)
        present(UINavigationController(rootViewController: settingsVC), animated: true)
    }
}
// MARK: - Setting UI
private extension MainViewController {
    func setUpInterface() {
        self.view.backgroundColor = .black
        ///     ImageView with Magic Ball image
        let imageBall = UIImage(asset: Asset.magicBallPNG)
        imageBallView.image = imageBall
        imageBallView.contentMode = .scaleAspectFit
        ///     Label for answer
        answerLabel.text = L10n.someAnswer
        answerLabel.textColor = .white
        answerLabel.textAlignment = .center
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.numberOfLines = 2
        ///     Count label
        countLabel.text = "Shakes – 0"
        countLabel.textColor = .cyan
        countLabel.textAlignment = .center
        countLabel.font = countLabel.font.withSize(20)
        ///     Button for present Settings ViewController
        settingsButton.setTitleColor(.cyan, for: .normal)
        settingsButton.setTitle(L10n.settings, for: .normal)
        settingsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        settingsButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        self.view.addSubview(imageBallView)
        self.view.addSubview(answerLabel)
        self.view.addSubview(countLabel)
        self.view.addSubview(settingsButton)
        setupCounLabel()
    }
// MARK: - Contraints
    func setupConstraints() {
        imageBallView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        answerLabel.snp.makeConstraints { make in
            make.center.equalTo(imageBallView).inset(20)
            make.width.equalTo(imageBallView).multipliedBy(0.2)
        }
        countLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        settingsButton.snp.makeConstraints {make in
            make.top.equalTo(imageBallView.snp.bottom).offset(140)
            make.centerX.equalTo(imageBallView)
            make.width.equalTo(imageBallView.snp.width).multipliedBy(0.5)
        }
    }
    func setupCounLabel() {
        countLabel.text = "Shakes – \(viewModel.loadTouches())"
    }
}
