//
//  GameScoreButton.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 28.08.2021.
//

import UIKit

enum SizeGameScoreButton {
    case large, standard
}

class GameScoreButton: UIButton {
    private let scoreLabel = UILabel()
    var score: Int?

    init(size: SizeGameScoreButton, title: String) {
        super.init(frame: .zero)
        addSubview(scoreLabel)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .gameButtonColor
        score = Int(title)
        switch size {
        case .large: layer.cornerRadius = 45
        case .standard: layer.cornerRadius = 27.5
        }
      
        setupScoreLabel(size: size, text: title)
        createConstraints(size: size)
    }
        
    
    
    private func setupScoreLabel(size: SizeGameScoreButton, text: String) {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        scoreLabel.text = text
        scoreLabel.shadowOffset = .init(width: 0, height: 2)
        scoreLabel.shadowColor = .init(red: 84/255, green: 120/255, blue: 111/255, alpha: 1)
        switch size {
        case .large: scoreLabel.font = .nunito800(40)
        case .standard: scoreLabel.font = .nunito800(25)
        }
    }
    
    private func createConstraints(size: SizeGameScoreButton) {
        let const: CGFloat
        switch size {
        case .large: const = 90
        case .standard: const = 55
        }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: const),
            widthAnchor.constraint(equalToConstant: const),
            
            scoreLabel.leftAnchor.constraint(equalTo: leftAnchor),
            scoreLabel.topAnchor.constraint(equalTo: topAnchor),
            scoreLabel.rightAnchor.constraint(equalTo: rightAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        backgroundColor = .gameButtonHighlightedColor
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        backgroundColor = .gameButtonColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
