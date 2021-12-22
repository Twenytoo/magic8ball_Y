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
    private var isResp = false
    private var is3secPassed = false
    private var viewModel: MainViewModelType
    private let disposeBag = DisposeBag()
    private let answerLabel = UILabel()
    private let countLabel = UILabel()
    private let imageBallView = UIImageView()
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        animateFirstRequest()
        viewModel.ballDidShake.onNext(())
    }
    private func updateAnswerLabel(answer: String) {
        DispatchQueue.main.async {
            UIView.transition(with: self.answerLabel,
                              duration: 0.5,
                              options: .transitionFlipFromTop,
                              animations: {
                self.answerLabel.text = answer
            },
                              completion: nil)
        }
    }
    private func presentErrorAlert(error: MyError?) {
        let alert = UIAlertController(title: "Oops...", message: error?.rawValue, preferredStyle: .alert)
        let okButton = UIAlertAction(title: L10n.done, style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    private func animateFirstRequest() {
        if !self.isResp {
            DispatchQueue.main.async {
                self.flipText()
            }
        }
    }
}
// MARK: - Setup
private extension MainViewController {
    func setup() {
        setUpInterface()
        setupConstraints()
        animateAnswerLabel()
        setupBindings()
    }
    // MARK: - Binging
    func setupBindings() {
        viewModel.countTouchesRX
            .map { count in
                "Shake - \(count)"
            }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.errorRx
            .observeOn(MainScheduler.instance)
            .subscribe(onError: { [unowned self] error in
                print(error, "!!!")
                self.presentErrorAlert(error: error as? MyError)
            }).disposed(by: disposeBag)
        viewModel.answerRx
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] answer in
                guard let self = self else { return }
                self.isResp = true
                self.updateAnswerLabel(answer: answer)
                self.viewModel.currentAnswer = answer
            } onError: { error in
                print(error, "!!!")
            } onCompleted: {
                print("Completed!!!")
            } onDisposed: {
                print("Disposed!!!")
            }
            .disposed(by: disposeBag)
    }
    // MARK: - Setting UI
    func setUpInterface() {
        viewModel.loadTouches()
        title = L10n.main
        view.backgroundColor = .black
        let imageBall = UIImage(asset: Asset.magicBallPNG)
        imageBallView.image = imageBall
        imageBallView.contentMode = .scaleAspectFit
        answerLabel.text = L10n.someAnswer
        answerLabel.textColor = .white
        answerLabel.textAlignment = .center
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.numberOfLines = 2
        countLabel.textColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        countLabel.textAlignment = .center
        countLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        view.addSubview(imageBallView)
        view.addSubview(answerLabel)
        view.addSubview(countLabel)
    }
    // MARK: - Contraints
    func setupConstraints() {
        imageBallView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
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
    func flipText() {
        wait3sec()
        UIView.transition(with: self.answerLabel,
                          duration: 0.1,
                          options: .transitionFlipFromTop) {
            self.answerLabel.text = self.viewModel.getAnimationAnswer()
        } completion: { _ in
            if !self.is3secPassed || !self.isResp {
                self.flipText()
            } else {
                self.answerLabel.text = self.viewModel.currentAnswer
            }
        }
    }
    func wait3sec() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.is3secPassed = true
        }
    }
}
