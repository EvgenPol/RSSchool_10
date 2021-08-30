//
//  GameRollViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 29.08.2021.
//

import UIKit
import AVFoundation

class GameRollViewController: UIViewController {
    lazy var dice = BasisDice.dicesStandard.randomDice()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        view.addSubview(dice)
        blurView.alpha = 0.94
       
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        blurView.addGestureRecognizer(gesture)
        dice.isUserInteractionEnabled = false
    
        blurView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dice.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dice.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}

fileprivate extension Array where Element == BasisDice {
    func randomDice() -> BasisDice {
        let randomNumber = Int(arc4random_uniform(UInt32(count)))
        return self[randomNumber]
    }
}

