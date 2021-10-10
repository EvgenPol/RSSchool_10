//
//  GamePageControl.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 29.08.2021.
//

import UIKit

final class GameCustomPageControl: UIScrollView {
    private var currentPlayer = 0
    private var stackNames = UIStackView(arrangedSubviews: [])

    init(namesOfPlayers: [Character]) {
        super.init(frame: .zero)
        setupStackNames(namesOfPlayers)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        isUserInteractionEnabled = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackNames(_ names: [Character]) {
        var arrayOfLabels = [UILabel]()
        for name in names {
            let label = createPlayerLabelWith(name: name)
            arrayOfLabels += [label]
        }
        stackNames = UIStackView(arrangedSubviews: arrayOfLabels)
        addSubview(stackNames)
        stackNames.translatesAutoresizingMaskIntoConstraints = false
        stackNames.alignment = .center
        stackNames.spacing = 5
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackNames.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackNames.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func createPlayerLabelWith(name: Character) -> UILabel {
        let label = UILabel()
        label.text = "\(name)"
        label.font = .nunito800(20)
        label.textAlignment = .center
        label.textColor = .gameSecondaryBackgroundColor
        return label
    }
    
    func updateCurrentPlayerIndex(_ player: Int) {
        guard let label = stackNames.subviews[player] as? UILabel,
              let currentPlayerLabel = stackNames.subviews[currentPlayer] as? UILabel else { return }
        currentPlayerLabel.textColor = .gameSecondaryBackgroundColor
        label.textColor = .gameLetterColor
        currentPlayer = player
    }
    
    func updatePlayers(namesOfPlayers: [Character]) {
        for i in namesOfPlayers.indices {
            if i > stackNames.arrangedSubviews.count - 1 {
                stackNames.addArrangedSubview(createPlayerLabelWith(name: namesOfPlayers[i]))
            } else {
                guard let label = stackNames.arrangedSubviews[i] as? UILabel else { fatalError("This View not UILabel") }
                label.text = "\(namesOfPlayers[i])"
            }
        }
        
        while stackNames.arrangedSubviews.count > namesOfPlayers.count {
            let lastIndex = stackNames.arrangedSubviews.count - 1
            stackNames.removeArrangedSubview(stackNames.arrangedSubviews[lastIndex])
            stackNames.subviews[lastIndex].removeFromSuperview()
        }
    }
}
