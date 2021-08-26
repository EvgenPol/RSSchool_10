//
//  NavigationViewController.swift
//  RSSchool_GameCounter
//
//  Created by Евгений Полюбин on 25.08.2021.
//

import UIKit


class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
       
        navigationBar.largeTitleTextAttributes = NSAttributedString.atrributesForNavigationLargeTitle
    
        navigationBar.titleTextAttributes = NSAttributedString.atrributesForNavigationTitle
        
        navigationBar.barTintColor = UIColor.darkGray
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            NSAttributedString.atrributesForBarButton,
            for: .normal)
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            NSAttributedString.atrributesForBarButton,
            for: .highlighted)
        UIFont.printAll()
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
               
        gameProcessVC.navigationItem.leftBarButtonItem = newGameButton
        gameProcessVC.navigationItem.rightBarButtonItem = resultButton
        gameProcessVC.title = "Game"
    }
    
    @objc private func presentNewGame() {
        present(GameProcessViewController(), animated: true, completion: nil)
    }
    
    @objc private func pushResults() {
    
    }
}

extension UIFont {
    static func printAll() {
        familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            fontNames(forFamilyName: familyName).sorted().forEach { fontName in
                print("\(fontName)")
            }
            print("---------------------")
        }
    }

}
