//
//  NavigationViewController.swift
//  RSSchool_GameCounter
//
//  Created by Евгений Полюбин on 25.08.2021.
//

import UIKit


class NavigationViewController: UINavigationController {
    let headerView = GameHeaderView(title: "Game")

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
       
        navigationBar.largeTitleTextAttributes = NSAttributedString.atrributesForNavigationLargeTitle
    
        navigationBar.titleTextAttributes = NSAttributedString.atrributesForNavigationTitle
        
        navigationBar.barTintColor = UIColor.gameMainBackgroundColor
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            NSAttributedString.atrributesForBarButton,
            for: .normal)
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            NSAttributedString.atrributesForBarButton,
            for: .highlighted)
    }
    
    func configureAddPlayerViewController(_ addPlayerVC: AddPlayerViewController) {
        let addButton = UIBarButtonItem.init(title: "Add",
                                             style: .plain,
                                             target: nil,
                                             action: nil)
        
        let backButton = UIBarButtonItem.init(title: "Back",
                                              style: .plain,
                                              target: self,
                                              action: #selector(popToRootViewController(animated:)))
        addPlayerVC.title = "Add player"
        addPlayerVC.navigationItem.rightBarButtonItem = addButton
        addPlayerVC.navigationItem.leftBarButtonItem = backButton
    }
    
    func configureNewGameViewController(_ newVC: NewGameViewController) {
        let cancelButton = UIBarButtonItem.init(title: "cancel",
                                              style: .plain,
                                              target: nil,
                                              action: nil)
        newVC.navigationItem.leftBarButtonItem = cancelButton
        newVC.title = "Game Counter"
    }
    
    func configureGameProcessViewController(_ gameProcessVC: GameProcessViewController) {
        let newGameButton = UIBarButtonItem.init(title: "New game",
                                             style: .plain,
                                             target: self,
                                             action: #selector(presentNewGame))
        
        let resultButton = UIBarButtonItem.init(title: "Results",
                                              style: .plain,
                                              target: self,
                                              action: #selector(pushResults))
        navigationBar.addSubview(headerView)
        
        gameProcessVC.navigationItem.leftBarButtonItem = newGameButton
        gameProcessVC.navigationItem.rightBarButtonItem = resultButton
        gameProcessVC.navigationItem.largeTitleDisplayMode = .always
        
        navigationBar.addSubview(headerView)
        headerView.diceButton = DiceFour(size: .mini)
        headerView.diceButton?.addTarget(self, action: #selector(pushRollViewController), for: .touchUpInside)
    
        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: navigationBar.leftAnchor,constant: 20),
            headerView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,constant: -20),
            headerView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
        ])
    }
    
    func configureGameResultsViewController(_ resultsVC: GameResultViewController) {
        let newGameButton = UIBarButtonItem.init(title: "New game",
                                             style: .plain,
                                             target: self,
                                             action: #selector(presentNewGame))
        
        let resumeButton = UIBarButtonItem.init(title: "Resume",
                                              style: .plain,
                                              target: self,
                                              action: #selector(returnGameProcess))
        
        resultsVC.navigationItem.leftBarButtonItem = newGameButton
        resultsVC.navigationItem.rightBarButtonItem = resumeButton
        resultsVC.navigationItem.largeTitleDisplayMode = .always
        resultsVC.title = "Results"
    }
    
    @objc private func returnGameProcess() {
        popToRootViewController(animated: true)
    }
    
    @objc private func presentNewGame() {
        let newGameVC = NewGameViewController()
        newGameVC.modalPresentationStyle = .fullScreen
        present(newGameVC, animated: true, completion: nil)
    }
    
    @objc private func pushResults() {
        pushViewController(GameResultViewController(), animated: true)
    }
    
    @objc private func pushRollViewController() {
        let rollVC = GameRollViewController()
        rollVC.modalPresentationStyle = .overCurrentContext
        present(rollVC, animated: true, completion: nil)
    }
    
}
