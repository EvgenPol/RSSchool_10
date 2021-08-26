//
//  TimerView.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class TimerView: UIView {
    let timerLabel = UILabel()
    let playButton = UIButton()
    var seconds = 0
    var timer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupTimer()
        setupPlayButton()
        createConstraints()
    }
    
    private func setupTimer() {
        timerLabel.text = "00:00"
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.nunito800(28)
        addSubview(timerLabel)
    }
    
    private func setupPlayButton() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("▷", for: .normal)
        playButton.titleLabel?.textColor = UIColor.white
        playButton.titleLabel?.font = UIFont(name: "SFCompactText-Bold", size: 26)
        playButton.addGestureRecognizer(UIGestureRecognizer.init(target: self, action: #selector(tapPlay)))
        addSubview(playButton)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 41),
            
            timerLabel.leftAnchor.constraint(equalTo: leftAnchor),
            timerLabel.topAnchor.constraint(equalTo: topAnchor),
            timerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            timerLabel.widthAnchor.constraint(equalToConstant: 75),
            
            playButton.leftAnchor.constraint(equalTo: timerLabel.rightAnchor, constant: 20),
            playButton.topAnchor.constraint(equalTo: topAnchor),
            playButton.rightAnchor.constraint(equalTo: rightAnchor),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapPlay() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            timerLabel.textColor = UIColor(named: "SecondaryBackgroundColor")
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.seconds += 1
            }
        }
    }
}
