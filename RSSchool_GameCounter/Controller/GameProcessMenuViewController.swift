//
//  GameProcessMenuViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 28.08.2021.
//

import UIKit

class GameProcessMenuViewController: UIViewController {
    let gameCounter = GameCounter.shared
    let leftArrow = GameArrowButton(type: .left)
    let rightArrow = GameArrowButton(type: .right)
    let largeScoreButton = GameScoreButton(size: .large, title: "+1")
    let stackButtons = UIStackView(arrangedSubviews: [
        GameScoreButton(size: .standard, title: "-10"),
        GameScoreButton(size: .standard, title: "-5"),
        GameScoreButton(size: .standard, title: "-1"),
        GameScoreButton(size: .standard, title: "+5"),
        GameScoreButton(size: .standard, title: "+10"),
    ])
    var scoreButtomTapped = false
    
    
    override func loadView() {
        super.loadView()
        view.addSubview(largeScoreButton)
        view.addSubview(leftArrow)
        view.addSubview(rightArrow)
        view.addSubview(stackButtons)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        createConstraints()
        
    }
    
    private func setupButtons() {
        let selector = #selector(addScorePoints(_:))
        let buttons = stackButtons.arrangedSubviews as? [GameScoreButton]
        buttons?.forEach { $0.addTarget(self, action: selector, for: .touchUpInside)}
        largeScoreButton.addTarget(self, action: selector, for: .touchUpInside)
        
        stackButtons.axis = .horizontal
        stackButtons.translatesAutoresizingMaskIntoConstraints = false
        stackButtons.spacing = 15
        stackButtons.alignment = .center
    }
    
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            largeScoreButton.topAnchor.constraint(equalTo: view.topAnchor),
            largeScoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            leftArrow.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 46),
            leftArrow.centerYAnchor.constraint(equalTo: largeScoreButton.centerYAnchor),
            
            rightArrow.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -46),
            rightArrow.centerYAnchor.constraint(equalTo: largeScoreButton.centerYAnchor),
            
            stackButtons.topAnchor.constraint(equalTo: largeScoreButton.bottomAnchor, constant: 22),
            stackButtons.centerXAnchor.constraint(equalTo: largeScoreButton.centerXAnchor),
        ])
    }
    
    @objc private func addScorePoints(_ sender: GameScoreButton) {
        guard let gameProcessVC = parent as? GameProcessViewController else { return }
        if let indexPath = gameProcessVC.currentIndexPathPlayer(),
           let points = sender.score, scoreButtomTapped == false {
            scoreButtomTapped = true
            gameCounter.updateScorePlayer(for: indexPath.row, with: points)
            
            UIView.performWithoutAnimation {
                gameProcessVC.playersCollection.reloadItems(at: [indexPath])
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let weakSelf = self else { return }
                var newPlayer = indexPath
                newPlayer.row += 1
                
                if newPlayer.row >= weakSelf.gameCounter.players.count {
                    newPlayer.row = 0
                }
                
                gameProcessVC.playersCollection.scrollToItem(at: newPlayer, at: .centeredHorizontally, animated: true)
                weakSelf.scoreButtomTapped = false
            }
        }
        
    }
}
