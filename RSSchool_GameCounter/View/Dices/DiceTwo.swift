//
//  DiceTwo.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class DiceTwo: BasisDice {
    init(size: SizeDice) {
        super.init(size: size, face: .one)
        
        let points = [BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size)]
        points.forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            points[0].topAnchor.constraint(equalTo: topAnchor, constant: points[0].bounds.height),
            points[0].leftAnchor.constraint(equalTo: leftAnchor, constant: points[0].bounds.height),
            
            points[1].bottomAnchor.constraint(equalTo: bottomAnchor, constant: points[1].bounds.height),
            points[1].rightAnchor.constraint(equalTo: rightAnchor, constant: points[1].bounds.height)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
