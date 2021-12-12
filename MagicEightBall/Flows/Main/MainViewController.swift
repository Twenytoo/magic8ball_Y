//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var isResp = false
    var is3secPassed = false
    //    Views
    private let answerLabel = UILabel()
    private let countLabel = UILabel()
    private let imageBallView = UIImageView()
    //    Model
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
        setupBindings()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        viewModel.ballDidShake.onNext(())
    }
    /// Updates the label on the ViewController in the TableViewCell
    /// - Parameter answer:String
    /// - Returns: Void
    private func updateAnswerLabel(answer: String) {
        DispatchQueue.main.async {
            self.answerLabel.text = answer
            self.isResp = true
        }
    }
    private func presentErrorAlert(error: MyError) {
        let alert = UIAlertController(title: "Oops...", message: error.rawValue, preferredStyle: .alert)
        let okButton = UIAlertAction(title: L10n.done, style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    private func flipText() {
        wait3sec()
        UIView.transition(with: self.answerLabel,
                          duration: 0.1,
                          options: .transitionFlipFromTop) {
            self.answerLabel.text = self.viewModel.getAnimationAnswer()
        } completion: { _ in
            if !self.is3secPassed || !self.isResp {
                self.flipText()
            }
        }
    }
    private func wait3sec() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.is3secPassed = true
        }
    }
}
// MARK: - Setting UI
private extension MainViewController {
    func setUpInterface() {
        viewModel.loadTouches()
        title = L10n.main
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
        ///    Count label
//        countLabel.text = "Shakes – 0"
        countLabel.textColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        countLabel.textAlignment = .center
        countLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        self.view.addSubview(imageBallView)
        self.view.addSubview(answerLabel)
        self.view.addSubview(countLabel)
//        setupCountLabel()
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
    }
    // MARK: - Animation
    func animateAnswerLabel() {
        UIView.transition(with: self.answerLabel,
                          duration: 0.5,
                          options: .transitionFlipFromTop,
                          animations: nil,
                          completion: nil)
    }
}
    // MARK: - RX
extension MainViewController {
    private func setupBindings() {
        viewModel.countTouchesRX
            .map(String.init)
            .map { count in
                "Shake - \(count)"
            }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.answerRx
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] answer in
                guard let self = self else { return }
                    if !self.isResp {
                            self.flipText()
                    }
                    if self.answerLabel.text == L10n.someAnswer {
                        self.answerLabel.text = ""
                    }
                    self.updateAnswerLabel(answer: answer)
                    self.animateAnswerLabel()
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
}
