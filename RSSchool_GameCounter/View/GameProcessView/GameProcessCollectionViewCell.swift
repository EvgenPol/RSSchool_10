//
//  GameProcessCollectionViewCell.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 28.08.2021.
//

import UIKit

class GameProcessCollectionViewCell: UICollectionViewCell {
    let nameLabel = UILabel()
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        backgroundColor = .gameSecondaryBackgroundColor
        
        setupNameLabel()
        setupCountLabel()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .nunito800(28)
        nameLabel.textColor = .gameProcessNamePlayerColor
        nameLabel.adjustsFontSizeToFitWidth = true
        addSubview(nameLabel)
    }
    
    private func setupCountLabel() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.font = .nunito700(100)
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.textColor = .white
        addSubview(countLabel)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23.5),
            
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
