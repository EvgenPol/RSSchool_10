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
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupForTopPlayers() {
        backgroundColor = .clear
        rightLabel.font = .nunito800(28)
        
        textLabel?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textLabel?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textLabel?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setuForTurnsPlayers() {
        backgroundColor = .gameSecondaryBackgroundColor
        
        textLabel?.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: -1).isActive = true
        textLabel?.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textLabel?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        textLabel?.textColor = .white
        textLabel?.font = .nunito800(24)
        rightLabel.font = .nunito800(20)
        
        let separator = UIView()
        addSubview(separator)
        separator.backgroundColor = .gameSeparatorCellColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: rightAnchor) .isActive = true
        separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 16) .isActive = true
        
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

