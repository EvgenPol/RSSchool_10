//
//  GameProcessViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController, TimerViewDelegate {
    
    let gameCounter = GameCounter.shared
    let playerCellID = "player"
    
    let timer = GameTimerView()
    let playersCollection = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let menuViewController = GameProcessMenuViewController()
   
    override func loadView() {
        super.loadView()
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        view.addSubview(timer)
        view.addSubview(playersCollection)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gameMainBackgroundColor
        setupTimerView()
        setupPlayersCollection()
        createConstraints()
        menuViewController.changeArrowsBlockHide(currentPlayer: gameCounter.currentPlayer)
        if let navigation = navigationController as? NavigationViewController {
            navigation.configureGameProcessViewController(self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let navigation = navigationController as? NavigationViewController {
            navigation.headerView.isHidden = false
        }
    }
    
    private func setupTimerView() {
        timer.seconds = gameCounter.gameTimer
        timer.playButton.sendActions(for: .touchUpInside)
        timer.delegate = self
    }
    
    private func setupPlayersCollection() {
        playersCollection.translatesAutoresizingMaskIntoConstraints = false
        playersCollection.backgroundColor = .gameMainBackgroundColor
        playersCollection.dataSource = self
        playersCollection.delegate = self
        playersCollection.isScrollEnabled = false
        playersCollection.showsHorizontalScrollIndicator = false
        playersCollection.register(GameProcessCollectionViewCell.self,
                                   forCellWithReuseIdentifier: playerCellID)
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(scrollLeft))
        swipeGestureLeft.direction = .left
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(scrollRight))
        swipeGestureRight.direction = .right
        
        playersCollection.addGestureRecognizer(swipeGestureLeft)
        playersCollection.addGestureRecognizer(swipeGestureRight)
        
        guard let layout = playersCollection.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: widthScreen/1.47, height: heightScreen/2.7)
        layout.sectionInset = .init(top: 0, left: 60, bottom: 0, right: 60)
        layout.minimumLineSpacing = 20
    }
    
    func currentIndexPathPlayer() -> IndexPath? {
        var pointStart = playersCollection.contentOffset
        pointStart.x += playersCollection.frame.width / 2
        pointStart.y += playersCollection.frame.height / 2
        if let indexPath = playersCollection.indexPathForItem(at: pointStart) {
            return indexPath
        } else {
            return nil
        }
    }
        
    //TimerViewDelegate
    func updateTimer(new time: Int) {
        gameCounter.updateTimer(new: time)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 22),
            timer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            
            playersCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            playersCollection.topAnchor.constraint(equalTo: timer.bottomAnchor, constant: 42),
            playersCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            playersCollection.heightAnchor.constraint(equalToConstant: heightScreen/2.6),
            
            menuViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            menuViewController.view.topAnchor.constraint(equalTo: playersCollection.bottomAnchor, constant: 28),
            menuViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            menuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


extension GameProcessViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gameCounter.players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playerCellID, for: indexPath)
        guard let gameCell = cell as? GameProcessCollectionViewCell else { return cell }
        gameCell.nameLabel.text = gameCounter.players[indexPath.row].name
        gameCell.countLabel.text = String(gameCounter.players[indexPath.row].score)
        return gameCell
    }

}
//MARK: Extension for work with scroll in CollectionView
extension GameProcessViewController {
    var scrollConstant: CGFloat {
        widthScreen/1.47 + 19
    }
    
    @objc func scrollRight() {
        if let currentPlayer = currentIndexPathPlayer(),
           currentPlayer.row < gameCounter.players.count - 1 {
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.playersCollection.contentOffset.x += weakSelf.scrollConstant
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    weakSelf.menuViewController.changeArrowsBlockHide(currentPlayer: weakSelf.currentIndexPathPlayer()!)
                    weakSelf.menuViewController.pageControl.updateCurentPlayer(weakSelf.currentIndexPathPlayer()!.row)
                }
            }
        }
    }
    
    @objc func scrollLeft() {
        if let currentPlayer = currentIndexPathPlayer(),
           currentPlayer.row > 0 {
        
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.playersCollection.contentOffset.x -= weakSelf.scrollConstant
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    weakSelf.menuViewController.changeArrowsBlockHide(currentPlayer: weakSelf.currentIndexPathPlayer()!)
                    weakSelf.menuViewController.pageControl.updateCurentPlayer(weakSelf.currentIndexPathPlayer()!.row)
                }
            }
        }
    }
    
    func scroll(at index: Int, direction: TypeGameArrowButton) {
       var cons = scrollConstant
        cons *= CGFloat(index)
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let weakSelf = self else { return }
            
            if direction == .left {
                weakSelf.playersCollection.contentOffset.x -= cons
            } else {
                weakSelf.playersCollection.contentOffset.x += cons
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                weakSelf.menuViewController.changeArrowsBlockHide(currentPlayer: weakSelf.currentIndexPathPlayer()!)
                weakSelf.menuViewController.pageControl.updateCurentPlayer(weakSelf.currentIndexPathPlayer()!.row)
            }
        }
    }
    
    func nextPlayer() {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let weakSelf = self else { return }
                let countPlayers = weakSelf.gameCounter.players.count - 1
                if weakSelf.currentIndexPathPlayer()!.row >= countPlayers {
                    weakSelf.scroll(at: countPlayers, direction: .left)
                } else {
                    weakSelf.scrollRight()
            }
        }
    }
    
    
    
}

extension Array where Element == BasisDice {
    func dice(face: FaceOfDice) -> BasisDice {
        switch face {
        case .one: return self[0]
        case .two: return self[1]
        case .three: return self[2]
        case .four: return self[3]
        case .five: return self[4]
        case .six: return self[5]
        }
    }
}
