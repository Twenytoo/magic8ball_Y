//
//  CustomTableViewCell.swift
//  MagicEightBall
//
//  Created by Артём on 16.10.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .purple
        contentView.addSubview(answerLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        answerLabel.frame = CGRect(x: 10,
                                   y: 0,
                                   width: contentView.frame.width,
                                   height: contentView.frame.height)
    }
///    Configurating cell
    func configure(text: String) {
        answerLabel.text = text
    }
}
