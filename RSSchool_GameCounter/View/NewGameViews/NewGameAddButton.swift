//
//  NewGameAddButton.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 30.08.2021.
//

import UIKit

class NewGameAddFooter: UIButton {
    let leftButton = GameCounterCellButton().createLeftButton(type: .add)
    let title = UILabel()

    init() {
        super.init(frame: .zero)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Add Player"
        title.font = .nunito600(16)
        title.textColor = .gameButtonColor
        title.translatesAutoresizingMaskIntoConstraints = false
        roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 15)
        backgroundColor = .gameSecondaryBackgroundColor
        addSubview(leftButton)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leftAnchor.constraint(equalTo: leftButton.rightAnchor, constant: 15),
            title.widthAnchor.constraint(equalToConstant: 100),
            title.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
