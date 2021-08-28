//
//  GameProcessViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController {
    let playerCellID = "player"
    let miniDices = BasisDice.Dices(size: .mini)
    let standartDices = BasisDice.Dices(size: .standard)
    let headerView = GameHeaderView(title: "Game")
    let timer = TimerView()
    let playersCollection = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let menuViewController = GameProcessMenuViewController()
    let pageControl = UIPageControl()
    let gameCounter = GameCounter.shared
    
    let leftArrow = UIButton()
    let rightArrow = UIButton()
    let counterOneButton = UIButton()
    let stackOfCounterButtons = UIStackView()
    let removeButton = UIButton()
    let pickerFirstLetter = UIPickerView()

    override func loadView() {
        super.loadView()
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        view.addSubview(headerView)
        view.addSubview(timer)
        view.addSubview(playersCollection)
        view.addSubview(pageControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigation = navigationController as? NavigationViewController {
            navigation.configureGameProcessViewController(self)
        }
        
        view.backgroundColor = UIColor.gameMainBackgroundColor
        headerView.diceButton = miniDices.dice(face: .four)
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
       
        setupPlayersCollection()
        setupPageControl()
        createConstraints()
    }
    
    private func setupPlayersCollection() {
        playersCollection.translatesAutoresizingMaskIntoConstraints = false
        playersCollection.backgroundColor = .gameMainBackgroundColor
        playersCollection.dataSource = self
        playersCollection.delegate = self
        playersCollection.isPagingEnabled = true
        playersCollection.showsHorizontalScrollIndicator = false
        playersCollection.register(GameProcessCollectionViewCell.self,
                                   forCellWithReuseIdentifier: playerCellID)
        
        guard let layout = playersCollection.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: widthScreen/1.47, height: heightScreen/2.7)
        layout.sectionInset = .init(top: 0, left: 60, bottom: 0, right: 60)
        layout.minimumLineSpacing = 20
    }
    
    private func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = gameCounter.players.count
        pageControl.tintColor = .gameSecondaryBackgroundColor
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
    
    func nextPlayer(oldPlayer indexPath: IndexPath) {
        playersCollection.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: heightScreen/9),
            headerView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 22),
            timer.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = currentIndexPathPlayer() {
            pageControl.currentPage = indexPath.row
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
