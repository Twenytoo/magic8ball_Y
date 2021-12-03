//
//  ViewController.swift
//  MagicEightBall
//
//  Created by Артём on 11.10.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    var isResp = false
    var is3secPassed = false
    //    Views
    private let answerLabel = UILabel()
    private let countLabel = UILabel()
    private let imageBallView = UIImageView()
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
        setAnimnation()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        if !isResp {
            DispatchQueue.main.async {
                self.flipText()
            }
        }
        viewModel.increaseAndSaveTouches()
        DispatchQueue.main.async {
            self.setupCountLabel()
        }
        if answerLabel.text == L10n.someAnswer { answerLabel.text = ""}
        viewModel.fetchAnswerByURL { answer in
            DispatchQueue.main.async {
                self.updateAnswerLabel(answer: answer)
                self.animateAnswerLabel()
            }
        } completionError: { error in
            DispatchQueue.main.async {
                self.presentErrorAlert(error: error)
            }
        }
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
        countLabel.textColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        countLabel.textAlignment = .center
        countLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        countLabel.layer.shadowColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        countLabel.layer.shadowOffset = CGSize(width: 2, height: 1)
        countLabel.layer.shadowOpacity = 0.7
        countLabel.layer.shadowRadius = 0.5
        self.view.addSubview(imageBallView)
        self.view.addSubview(answerLabel)
        self.view.addSubview(countLabel)
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
    }
    func setupCountLabel() {
        countLabel.text = "Shakes – \(viewModel.loadTouches())"
    }
    // MARK: - Animation
    func setAnimnation() {
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
//        Answer label animation
        let labelAnswer = UILabel()
        labelAnswer.text = answerLabel.text
        labelAnswer.frame = CGRect(x: answerLabel.frame.origin.x,
                             y: answerLabel.frame.origin.y,
                             width: answerLabel.frame.width,
                             height: answerLabel.frame.height)
        labelAnswer.textColor = .white
        labelAnswer.textAlignment = .center
        labelAnswer.adjustsFontSizeToFitWidth = true
        labelAnswer.numberOfLines = 2
        self.view.addSubview(labelAnswer)
        self.gravity?.addItem(labelAnswer)
        self.collider?.addItem(labelAnswer)
        self.itemBehviour?.addItem(labelAnswer)
//        Count label animation
        let labelCount = UILabel()
        labelCount.text = "\(viewModel.loadTouches())"
        labelCount.textColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        labelCount.textAlignment = .center
        labelCount.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        labelCount.frame = CGRect(x: countLabel.frame.origin.x,
                             y: countLabel.frame.origin.y,
                             width: countLabel.frame.width,
                             height: countLabel.frame.height)
        labelCount.textAlignment = .right
        self.view.addSubview(labelCount)
        self.gravity?.addItem(labelCount)
        self.collider?.addItem(labelCount)
        self.itemBehviour?.addItem(labelCount)
    }
    func shakeBallAnimation() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: imageBallView.center.x - 3,
                                                            y: imageBallView.center.y - 3))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: imageBallView.center.x + 3,
                                                          y: imageBallView.center.y + 3))
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 30
        shakeAnimation.autoreverses = true
        imageBallView.layer.add(shakeAnimation, forKey: "position")
    }
}
