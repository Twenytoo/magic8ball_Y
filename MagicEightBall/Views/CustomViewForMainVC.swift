//
//  CustomView.swift
//  MagicEightBall
//
//  Created by Артём on 13.11.2021.
//

import UIKit

class CustomViewForMainVC: UIView {
    let answerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
    
    init() {
        super.init(frame: CGRect())
        setUpInterface()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpInterface() {
        self.backgroundColor = .black
//      Creating ImageView with Magic Ball image
        let imageBall = UIImage(asset: Asset.magicBallPNG)
        let imageBallView = UIImageView(image: imageBall)
        imageBallView.frame = CGRect(x: 20, y: 100, width: 400, height: 400)
        self.addSubview(imageBallView)
//        Creating label for answer
        answerLabel.text = L10n.someAnswer
        answerLabel.textColor = .white
        answerLabel.textAlignment = .center
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.numberOfLines = 2
        answerLabel.center = imageBallView.center
        self.addSubview(answerLabel)
    }
}
