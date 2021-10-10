//
//  GameRollViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 29.08.2021.
//

import UIKit
import AVFoundation

final class GameRollViewController: UIViewController {
    lazy var dice = DieView.dieStandard
    private var blurView: UIVisualEffectView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupBackground()
        view.addSubview(dice)
        dice.isUserInteractionEnabled = false
        createConstraints()
        guard let face = randomFace() else { return }
        dice.faceDie = face
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    private func setupBackground() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        blurView.alpha = 0.94
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        blurView.addGestureRecognizer(gesture)
        self.blurView = blurView
    }
    
    private func randomFace() -> FaceDie? {
        let randomNumber = Int(arc4random_uniform(UInt32(6)))
        return FaceDie(rawValue: randomNumber)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            blurView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.rightAnchor.constraint(equalTo: view.rightAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dice.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dice.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

