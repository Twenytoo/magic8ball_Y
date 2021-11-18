//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    private var answerLabel = UILabel()
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
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        viewModel.fetchAnswerByURL {answer in
            self.updateAnswerLabel(answer: answer)
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
    private func addButton() -> UIButton {
        let settingsButton = UIButton(frame: CGRect(x: 115, y: 500, width: 200, height: 100))
        settingsButton.setTitleColor(.cyan, for: .normal)
        settingsButton.setTitle(L10n.settings, for: .normal)
        settingsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        settingsButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return settingsButton
    }
    @objc private func buttonDidTap() {
        let setVC = SettingsViewController()
        present(UINavigationController(rootViewController: setVC), animated: true)
    }
}
// MARK: - Setting UI
private extension MainViewController {
    func setUpInterface() {
        self.view.backgroundColor = .black
///     ImageView with Magic Ball image
        let imageBall = UIImage(asset: Asset.magicBallPNG)
        let imageBallView = UIImageView(image: imageBall)
        imageBallView.frame = CGRect(x: 20, y: 100, width: 400, height: 400)
        self.view.addSubview(imageBallView)
///     Label for answer
        answerLabel.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
        answerLabel.text = L10n.someAnswer
        answerLabel.textColor = .white
        answerLabel.textAlignment = .center
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.numberOfLines = 2
        answerLabel.center = imageBallView.center
        self.view.addSubview(answerLabel)
        self.view.addSubview(addButton())
    }
}
