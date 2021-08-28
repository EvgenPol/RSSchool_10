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
    var playButtonLayer: CAShapeLayer!
    var seconds = 0 {
        didSet { timerLabel.text = seconds.formateSecondsForTimerDisplay(seconds) }
    }
    
    var timer: Timer?

    private func setupTimerLabel() {
        timerLabel.text = "00:00"
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.nunito800(28)
        timerLabel.textColor = .gameSecondaryBackgroundColor
        addSubview(timerLabel)
    }
    
    private func setupPlayButton() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.titleLabel?.textColor = UIColor.white
        playButton.titleLabel?.font = .nunito800(28)
        playButton.addTarget(self, action: #selector(tapPlay), for: .touchUpInside)
        addSubview(playButton)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.lineJoin = .round
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = UIBezierPath.runButtonPath.cgPath
        playButton.layer.addSublayer(shapeLayer)
        playButtonLayer = shapeLayer
    }
    
    @objc private func tapPlay() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            timerLabel.textColor = UIColor.gameSecondaryBackgroundColor
            playButton.setTitle("", for: .normal)
            playButtonLayer.isHidden = false
        } else {
            timerLabel.textColor = .white
            playButton.setTitle("‖", for: .normal)
            playButtonLayer.isHidden = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] _ in
                self.seconds += 1
            }
        }
    }
    
    
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 41),
            
            timerLabel.leftAnchor.constraint(equalTo: leftAnchor),
            timerLabel.topAnchor.constraint(equalTo: topAnchor),
            timerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            timerLabel.widthAnchor.constraint(equalToConstant: 75),
            
            playButton.heightAnchor.constraint(equalToConstant: 20),
            playButton.widthAnchor.constraint(equalToConstant: 20),
            playButton.leftAnchor.constraint(equalTo: timerLabel.rightAnchor, constant: 20),
            playButton.rightAnchor.constraint(equalTo: rightAnchor),
            playButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor)
        ])
    }
}


extension Int {
    func formateSecondsForTimerDisplay(_ seconds: Int) -> String {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.minute, .second]
        dateFormatter.unitsStyle = .positional
        dateFormatter.zeroFormattingBehavior = .pad
        return dateFormatter.string(from: TimeInterval(seconds)) ?? "00:00"
    }
}

extension TimerView {
    convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupTimerLabel()
        setupPlayButton()
        createConstraints()
    }
}

fileprivate extension UIBezierPath {
    static var runButtonPath: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 20))
        path.addLine(to: CGPoint(x: 17, y: 10))
        path.close()
        return path
    }
}
