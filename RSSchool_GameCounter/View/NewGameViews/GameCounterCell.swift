//
//  GameCounterCell.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 25.08.2021.
//

import UIKit

final class GameCounterCell: UITableViewCell {
    var leftButton: GameCounterCellButton!
    let title = UILabel()
    private let separator = UIView()
    
    func configureCell() {
        configureDefaultCell()
        backgroundColor = .gameSecondaryBackgroundColor
        addCons()
    }
    
    private func configureDefaultCell() {
        leftButton = GameCounterCellButton().createLeftButton(type: .delete)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .gameSeparatorCellColor
        title.textColor = .white
        title.font = UIFont.nunito800(20)
        addSubview(leftButton)
        addSubview(title)
        addSubview(separator)
    }
    
    private func addCons() {
        title.translatesAutoresizingMaskIntoConstraints = false
     
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            title.leftAnchor.constraint(equalTo: leftButton.rightAnchor, constant: 15),
            title.centerYAnchor.constraint(equalTo: leftButton.centerYAnchor),
            
            separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            separator.rightAnchor.constraint(equalTo: rightAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}


