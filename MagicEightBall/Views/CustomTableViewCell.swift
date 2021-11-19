//
//  CustomTableViewCell.swift
//  MagicEightBall
//
//  Created by Артём on 16.10.2021.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .cyan
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(answerLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraintsForCell()
    }
///    Configurating cell
    func configure(text: String) {
        answerLabel.text = text
    }
    func addConstraintsForCell() {
        answerLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(40)
            make.width.height.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
