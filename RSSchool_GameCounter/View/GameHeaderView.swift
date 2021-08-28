//
//  TitleView.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 28.08.2021.
//

import UIKit

class GameHeaderView: UILabel {
    var diceButton: BasisDice? {
        didSet { setupDiceButton() }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        text = title
        font = UIFont.nunito800(36)
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDiceButton() {
        guard let dice = diceButton else { return }
        addSubview(dice)
        dice.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dice.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
