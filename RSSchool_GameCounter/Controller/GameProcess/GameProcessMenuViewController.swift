//
//  GameProcessMenuViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 28.08.2021.
//

import UIKit

final class GameProcessMenuViewController: UIViewController {
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
    lazy var pageControl = GameCustomPageControl(namesOfPlayers: closureForPageControl())
     
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
        pageControl.updateCurentPlayer(gameCounter.currentPlayerIndex)
        changeArrowsBlockHide(currentPlayer: gameCounter.currentPlayerIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pageControl.updatePlayers(namesOfPlayers: closureForPageControl())
        pageControl.updateCurentPlayer(gameCounter.currentPlayerIndex)
        changeArrowsBlockHide(currentPlayer: gameCounter.currentPlayerIndex)
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
            largeScoreButton.bottomAnchor.constraint(equalTo: stackButtons.topAnchor, constant: -22),
            largeScoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            leftArrow.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 46),
            leftArrow.centerYAnchor.constraint(equalTo: largeScoreButton.centerYAnchor),
            
            rightArrow.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -46),
            rightArrow.centerYAnchor.constraint(equalTo: largeScoreButton.centerYAnchor),
            
            stackButtons.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20),
            stackButtons.centerXAnchor.constraint(equalTo: largeScoreButton.centerXAnchor),
            
            undoButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
            undoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 24)
            
        ])
    }
    
    @objc private func addScorePoints(_ sender: GameScoreButton) {
        guard let gameProcessVC = parent as? GameProcessViewController else { return }
        if let indexPath = gameProcessVC.currentIndexPathPlayer(), let points = sender.score {
            largeScoreButton.isUserInteractionEnabled = false
            stackButtons.arrangedSubviews.forEach { $0.isUserInteractionEnabled = false }
            gameCounter.updateScorePlayer(for: indexPath.row, with: points)
            gameCounter.moves += [(indexPath, points)]
        
            UIView.performWithoutAnimation {
                gameProcessVC.playersCollection.reloadItems(at: [indexPath])
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                guard let self = self else { return }
                gameProcessVC.nextPlayer()
                self.largeScoreButton.isUserInteractionEnabled = true
                self.stackButtons.arrangedSubviews.forEach { $0.isUserInteractionEnabled = true }
            }
        }
    }
    
    @objc private func tapUndo() {
        guard !gameCounter.moves.isEmpty,
              let mainGameVC = parent as? GameProcessViewController
        else { return }
        
        let move = gameCounter.moves.removeLast()
        let currentPlayer = mainGameVC.currentIndexPathPlayer()!.row
        
        if currentPlayer > move.player.row {
            mainGameVC.scroll(at: (currentPlayer - move.player.row), direction: .left, isNewMove: true)
        } else {
            mainGameVC.scroll(at: (move.player.row - currentPlayer), direction: .right, isNewMove: true)
        }
        
        gameCounter.players[move.player.row].score -= move.points
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.performWithoutAnimation {
                mainGameVC.playersCollection.reloadItems(at: [move.player])
            }
        }
    }
    
    @objc private func tapArrow(_ sender: GameArrowButton) {
        guard let gameProcessVC = parent as? GameProcessViewController,
              let currentPlayer = gameProcessVC.currentIndexPathPlayer()?.row else { return }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let weakSelf = self else { return }
            switch sender.type {
            case .left where currentPlayer == 0:
                gameProcessVC.scroll(at: weakSelf.gameCounter.players.count - 1, direction: .right, isNewMove: true)
            case .left:
                gameProcessVC.scrollLeft()
            case .right where currentPlayer == weakSelf.gameCounter.players.count - 1:
                gameProcessVC.scroll(at: weakSelf.gameCounter.players.count - 1, direction: .left, isNewMove: true)
            case .right:
                gameProcessVC.scrollRight()
            }
        }
       
    }
    
    func changeArrowsBlockHide(currentPlayer: Int) {
        if currentPlayer == 0 {
            leftArrow.layerWithArrowBlock.isHidden = false
        } else {
            leftArrow.layerWithArrowBlock.isHidden = true
        }
        if currentPlayer == gameCounter.players.count - 1 {
            rightArrow.layerWithArrowBlock.isHidden = false
        } else {
            rightArrow.layerWithArrowBlock.isHidden = true
        }
    }
}

fileprivate extension GameProcessMenuViewController {
    var closureForPageControl: () -> [Character] {{ [weak self] in
        guard let weakSelf = self else { return [] }
        var names = [Character]()
        for player in weakSelf.gameCounter.players {
            guard let letter = player.name.first else { continue }
            names += [letter]
        }
        return names
    }}
    
}
