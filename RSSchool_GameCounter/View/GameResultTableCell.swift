//
//  GameResultTableCell.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 30.08.2021.
//

import UIKit

class GameResultTableCell: UITableViewCell {
    let rightLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(rightLabel)
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        textLabel?.lineBreakMode = .byClipping
        rightLabel.lineBreakMode = .byClipping
        rightLabel.textColor = .white
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.textAlignment = .right
        selectionStyle = .none
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupForTopPlayers() {
        backgroundColor = .clear
        rightLabel.font = .nunito800(28)
        guard let textLabel = textLabel else { return }
        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: leftAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setuForTurnsPlayers() {
        backgroundColor = .gameSecondaryBackgroundColor
        
        textLabel?.textColor = .white
        textLabel?.font = .nunito800(24)
        rightLabel.font = .nunito800(20)
        
        let separator = UIView()
        addSubview(separator)
        guard let textLabel = textLabel else { return }
        separator.backgroundColor = .gameSeparatorCellColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: -1),
            textLabel.heightAnchor.constraint(equalToConstant: 45),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.rightAnchor.constraint(equalTo: rightAnchor),
            separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
    }
    
    private func createConstraints() {
        guard let title = textLabel else { return }
        NSLayoutConstraint.activate([
            title.rightAnchor.constraint(equalTo: rightLabel.leftAnchor),
            rightLabel.topAnchor.constraint(equalTo: topAnchor),
            rightLabel.widthAnchor.constraint(equalToConstant: 80),
            rightLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

