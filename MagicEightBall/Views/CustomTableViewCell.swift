//
//  CustomTableViewCell.swift
//  MagicEightBall
//
//  Created by Артём on 16.10.2021.
//

import UIKit
import SnapKit

class DateFormatterForCell {
    static let shared = DateFormatter()
    private init() {}
}
class CustomTableViewCell: UITableViewCell {
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatterForCell.shared
        dateFormatter.setLocalizedDateFormatFromTemplate("MM-dd-yyyy HH:mm")
        return dateFormatter
    }
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(answerLabel)
        contentView.addSubview(dateLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraintsForCell()
    }
///    Configurating cell
    func configureTextAnswer(text: String) {
        answerLabel.text = text
    }
    func configureTextDate(date: Date) {
        let dateString = dateFormatter.string(from: date)
        dateLabel.text = dateString
    }
    func addConstraintsForCell() {
        answerLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(40)
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.centerY.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(300)
            make.height.equalTo(100)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
