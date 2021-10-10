//
//  TitleView.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 28.08.2021.
//

import UIKit

final class GameHeaderView: UILabel {
    var diceButton: DieView? {
        didSet { setupDiceButton() }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        text = title
        font = UIFont.nunito800(36)
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupDiceButton() {
        guard let dice = diceButton else { return }
        addSubview(dice)
        NSLayoutConstraint.activate([
            dice.centerYAnchor.constraint(equalTo: centerYAnchor),
            dice.rightAnchor.constraint(equalTo: rightAnchor),
        ])
       
    }
}
