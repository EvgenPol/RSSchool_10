//
//  GameProcessViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController {
    let miniDices = BasisDice.Dices(size: .mini)
    let standartDices = BasisDice.Dices(size: .standart)
    let timer = UILabel()
    let playTimer = UIButton()
    let playersTable = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let leftArrow = UIButton()
    let rightArrow = UIButton()
    let counterOneButton = UIButton()
    let stackOfCounterButtons = UIStackView()
    let removeButton = UIButton()
    let pickerFirstLetter = UIPickerView()
    
    lazy var diceView: BasisDice = miniDices[3]
    
    override func loadView() {
        super.loadView()
        view.addSubview(diceView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainBackgroundColor")
        if let navigation = navigationController as? NavigationViewController {
            navigation.configureGameProcessViewController(self)
        }
    }
}
