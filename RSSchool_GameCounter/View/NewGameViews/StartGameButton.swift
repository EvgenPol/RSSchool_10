//
//  StartGameButton.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class StartGameButton: UIButton {
    private let title = UILabel()
    private let viewTitle = UIView()
    var addedMask = false
    
     init() {
        super.init(frame: .zero)
        backgroundColor = .gameButtonHighlightedColor
        layer.cornerRadius = 33
        layer.masksToBounds = true
        setupTitle()
        createConstaints()
    }
    
    private func setupTitle() {
        addSubview(viewTitle)
        viewTitle.addSubview(title)
        title.text = "Start game"
        title.textColor = UIColor.white
        title.font = .nunito800(24)
        title.shadowOffset = CGSize(width: 0, height: 2)
        title.shadowColor = UIColor(red: 84/255, green: 120/255, blue: 111/255, alpha: 1)
        viewTitle.backgroundColor = .gameButtonColor
    }
    
    private func createConstaints() {
        translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 65),
            title.centerXAnchor.constraint(equalTo: viewTitle.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: viewTitle.centerYAnchor),
        ])
    }
    
     func setupMaskedTitle() {
        let mask = UIView(frame: bounds)
        mask.frame.origin.y -= 5
        mask.layer.cornerRadius = 33
        mask.backgroundColor = UIColor.white
        viewTitle.frame = bounds
        viewTitle.mask = mask
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewTitle.backgroundColor = backgroundColor
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewTitle.backgroundColor = .gameButtonColor
    }
}
