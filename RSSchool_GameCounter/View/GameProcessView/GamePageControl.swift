//
//  GamePageControl.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 29.08.2021.
//

import UIKit

class GameCustomPageControl: UIScrollView {
    private var currentPlayer = 0
    private var stackNames: UIStackView?

    init(namesOfPlayers: [Character]) {
        super.init(frame: .zero)
        setupStackNames(namesOfPlayers)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        isUserInteractionEnabled = false
        delegate = self
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackNames(_ names: [Character]) {
        var arrayOfLabels = [UILabel]()
        for name in names {
            let label = UILabel()
            label.text = "\(name)"
            label.font = .nunito800(20)
            label.textAlignment = .center
            label.textColor = .gameSecondaryBackgroundColor
            arrayOfLabels += [label]
        }
        stackNames = UIStackView(arrangedSubviews: arrayOfLabels)
        stackNames?.translatesAutoresizingMaskIntoConstraints = false
        stackNames?.alignment = .center
        stackNames?.spacing = 5
    }
    
    private func setupConstraints() {
        guard let stack = stackNames else { return }
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func updateCurentPlayer(_ player: Int) {
        guard let players = stackNames,
              let label = players.subviews[player] as? UILabel,
              let currentPlayerLabel = players.subviews[currentPlayer] as? UILabel else { return }
        
        currentPlayerLabel.textColor = .gameSecondaryBackgroundColor
        label.textColor = .gameLetterColor
        currentPlayer = player
    }
}

extension GameCustomPageControl: UIScrollViewDelegate {
   
}
 
