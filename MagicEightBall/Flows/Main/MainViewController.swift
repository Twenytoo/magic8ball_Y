//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    //    Views
    private let answerLabel = UILabel()
    private let countLabel = UILabel()
    private let imageBallView = UIImageView()
    private let activityIndicator  = UIActivityIndicatorView()
    //    Animation
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collider: UICollisionBehavior?
    var itemBehviour: UIDynamicItemBehavior?
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
        setAnmination()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        animateAnswerLabel()
        viewModel.increaseAndSaveTouches()
        DispatchQueue.main.async {
            self.setupCountLabel()
        }
        if answerLabel.text == L10n.someAnswer { answerLabel.text = ""}
        activityIndicator.startAnimating()
        viewModel.fetchAnswerByURL { answer in
            DispatchQueue.main.async {
                self.updateAnswerLabel(answer: answer)
                self.activityIndicator.stopAnimating()
//                self.animateAnswerLabel()
            }
        } completionError: { error in
            DispatchQueue.main.async {
                self.presentErrorAlert(error: error)
            }
        }
        UIView.transition(with: self.answerLabel,
                          duration: 0.5,
                          options: .transitionFlipFromTop,
                          animations: nil,
                          completion: nil
        )
    }
    /// Updates the label on the ViewController in the TableViewCell
    /// - Parameter answer:String
    /// - Returns: Void
    private func updateAnswerLabel(answer: String) {
        DispatchQueue.main.async {
            self.answerLabel.text = answer
        }
    }
    private func presentErrorAlert(error: MyError) {
        let alert = UIAlertController(title: "Oops...", message: error.rawValue, preferredStyle: .alert)
        let okButton = UIAlertAction(title: L10n.done, style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
// MARK: - Setting UI
private extension MainViewController {
    func setUpInterface() {
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
        countLabel.text = "Shakes – 0"
        countLabel.textColor = .darkGray
        countLabel.textAlignment = .center
        countLabel.font = countLabel.font.withSize(20)
        self.view.addSubview(imageBallView)
        self.view.addSubview(answerLabel)
        self.view.addSubview(countLabel)
        self.view.addSubview(activityIndicator)
        ///     Activity Indcator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        setupCountLabel()
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
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(answerLabel)
            make.centerY.equalTo(answerLabel.snp.centerY)
        }
    }
    func setupCountLabel() {
        countLabel.text = "Shakes – \(viewModel.loadTouches())"
    }
    // MARK: - Animation
    func setAnmination() {
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collider = UICollisionBehavior()
        itemBehviour = UIDynamicItemBehavior()
        collider?.translatesReferenceBoundsIntoBoundary = true
        collider?.collisionMode = .everything
        itemBehviour?.elasticity = 0.7
        itemBehviour?.friction = 0.7
        itemBehviour?.allowsRotation = true
        animator?.addBehavior(gravity!)
        animator?.addBehavior(collider!)
        animator?.addBehavior(itemBehviour!)
    }
    func animateAnswerLabel() {
        let label = UILabel()
        label.text = answerLabel.text
        label.frame = CGRect(x: answerLabel.frame.origin.x,
                             y: answerLabel.frame.origin.y,
                             width: answerLabel.frame.width,
                             height: answerLabel.frame.height)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        self.view.addSubview(label)
        self.gravity?.addItem(label)
        self.collider?.addItem(label)
        self.itemBehviour?.addItem(label)
    }
}
