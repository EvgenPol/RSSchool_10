//
//  DiceThree.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit
class DiceThree: BasisDice {
    init(size: SizeDice) {
        super.init(size: size, face: .one)
        
        let points = [BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size)]
        points.forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            points[0].topAnchor.constraint(equalTo: topAnchor, constant: bounds.height/6),
            points[0].leftAnchor.constraint(equalTo: leftAnchor, constant: bounds.height/6),
            
            points[1].centerXAnchor.constraint(equalTo: centerXAnchor),
            points[1].centerYAnchor.constraint(equalTo: centerYAnchor),
            
            points[2].bottomAnchor.constraint(equalTo: bottomAnchor, constant: bounds.height/6),
            points[2].rightAnchor.constraint(equalTo: rightAnchor, constant: bounds.height/6)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
