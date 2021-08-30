//
//  GameCounterCell.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 25.08.2021.
//

import UIKit

class GameCounterCell: UITableViewCell {
    private var header: UILabel?
    var leftButton: GameCounterCellButton!
    var rightButton : UIButton?
    let title = UILabel()
    private let separator = UIView()
    
    func configureCell() {
        configureDefaultCell()
        backgroundColor = .gameSecondaryBackgroundColor
        addCons()
    }
    
    private func configureDefaultCell() {
        leftButton = GameCounterCellButton().createLeftButton(type: .delete)
        let rightButton = GameCounterCellButton().createRightButton()
        self.rightButton = rightButton
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .gameSeparatorCellColor
        title.textColor = .white
        title.font = UIFont.nunito800(20)
        addSubview(leftButton)
        addSubview(rightButton)
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
        
        if let head = header {
            head.translatesAutoresizingMaskIntoConstraints = false
            head.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
            head.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        }
        
        if let rightButton = rightButton {
            rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
            rightButton.centerYAnchor.constraint(equalTo: leftButton.centerYAnchor).isActive = true
        }
        
    }
}


