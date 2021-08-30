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
    let undoButton = GameUndoButton(frame: .zero)
    let pageControl = GameCustomPageControl(namesOfPlayers: {
        var names = [Character]()
        for player in GameCounter.shared.players {
            guard let letter = player.name.first else { continue }
            names += [letter]
        }
        return names
    }())
     
    override func loadView() {
        super.loadView()
        view.addSubview(largeScoreButton)
        view.addSubview(leftArrow)
        view.addSubview(rightArrow)
        view.addSubview(stackButtons)
        view.addSubview(pageControl)
        view.addSubview(undoButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        createConstraints()
        pageControl.updateCurentPlayer(0)
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
        
        undoButton.translatesAutoresizingMaskIntoConstraints = false
        undoButton.addTarget(self, action: #selector(tapUndo), for: .touchUpInside)
        rightArrow.addTarget(self, action: #selector(tapArrow(_:)), for: .touchUpInside)
        leftArrow.addTarget(self, action: #selector(tapArrow(_:)), for: .touchUpInside)
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
            
            undoButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            undoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            
            pageControl.topAnchor.constraint(equalTo: stackButtons.bottomAnchor, constant: 20),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 24)
            
        ])
    }
    
    @objc private func addScorePoints(_ sender: GameScoreButton) {
        guard let gameProcessVC = parent as? GameProcessViewController else { return }
        if var indexPath = gameProcessVC.currentIndexPathPlayer(), let points = sender.score {
            largeScoreButton.isUserInteractionEnabled = false
            stackButtons.arrangedSubviews.forEach { $0.isUserInteractionEnabled = false }
            gameCounter.updateScorePlayer(for: indexPath.row, with: points)
            gameCounter.moves += [(indexPath, points)]
            print(gameCounter.moves.count)
            
            UIView.performWithoutAnimation {
                gameProcessVC.playersCollection.reloadItems(at: [indexPath])
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let weakSelf = self else { return }
                gameProcessVC.nextPlayer()
                weakSelf.largeScoreButton.isUserInteractionEnabled = true
                weakSelf.stackButtons.arrangedSubviews.forEach { $0.isUserInteractionEnabled = true }
            }
        }
    }
    
    @objc private func tapUndo() {
        guard !gameCounter.moves.isEmpty else { return }
        let move = gameCounter.moves.removeLast()
        gameCounter.players[move.player.row].score -= move.points
        let mainGameVC = parent as? GameProcessViewController
        
//        if let lastPlayer = gameCounter.moves.last {
//            mainGameVC?.nextPlayer(lastPlayer.player)
//        } else {
//            mainGameVC?.nextPlayer(IndexPath.init(row: 0, section: 0))
//        }
        
        UIView.performWithoutAnimation {
            mainGameVC?.playersCollection.reloadItems(at: [move.player])
        }
        
    }
    
    @objc private func tapArrow(_ sender: GameArrowButton) {
        guard let gameProcessVC = parent as? GameProcessViewController,
              let currentPlayer = gameProcessVC.currentIndexPathPlayer()?.row else { return }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let weakSelf = self else { return }
            switch sender.type {
            case .left where currentPlayer == 0:
                gameProcessVC.scroll(at: weakSelf.gameCounter.players.count - 1, direction: .right)
            case .left:
                gameProcessVC.scrollLeft()
            case .right where currentPlayer == weakSelf.gameCounter.players.count - 1:
                gameProcessVC.scroll(at: weakSelf.gameCounter.players.count - 1, direction: .left)
            case .right:
                gameProcessVC.scrollRight()
            }
        }
       
    }
    
    func changeArrowsBlockHide(currentPlayer: IndexPath) {
        if currentPlayer.row == 0 {
            leftArrow.layerWithArrowBlock.isHidden = false
        } else {
            leftArrow.layerWithArrowBlock.isHidden = true
        }
        if currentPlayer.row == gameCounter.players.count - 1 {
            rightArrow.layerWithArrowBlock.isHidden = false
        } else {
            rightArrow.layerWithArrowBlock.isHidden = true
        }
    }
}
