//
//  StartGameButton.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class StartGameButton: UIButton {
    let title = UILabel()
    var addedMask = false
    
     init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 132/255, green: 184/255, blue: 173/255, alpha: 1)
        
        addSubview(title)
        
        title.text = "Start game"
        title.textColor = UIColor.white
        title.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        
        title.shadowOffset = CGSize(width: 0, height: 2)
        title.shadowColor = UIColor(red: 84/255, green: 120/255, blue: 111/255, alpha: 1)
        
        layer.cornerRadius = 33
        createConstaints()
    }
    
    private func createConstaints() {
        translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 65),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
     func addMask() {
        //TODO:
        //layer.shadowColor = UIColor(red: 84/255, green: 120/255, blue: 111/255, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
