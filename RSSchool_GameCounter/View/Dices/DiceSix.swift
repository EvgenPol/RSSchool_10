//
//  DiceSix.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class DiceSix: BasisDice {
    init(size: SizeDice) {
        super.init(size: size, face: .one)
        
        let points = [BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size)]
        points.forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            points[0].topAnchor.constraint(equalTo: topAnchor, constant: points[0].bounds.height * 0.75),
            points[0].leftAnchor.constraint(equalTo: leftAnchor, constant: points[0].bounds.height),
            
            points[1].centerYAnchor.constraint(equalTo: centerYAnchor),
            points[1].leftAnchor.constraint(equalTo: leftAnchor, constant: points[1].bounds.height),
            
            points[2].bottomAnchor.constraint(equalTo: bottomAnchor, constant: points[2].bounds.height * 0.75),
            points[2].leftAnchor.constraint(equalTo: leftAnchor, constant: points[2].bounds.height),
            
            points[3].topAnchor.constraint(equalTo: topAnchor, constant: points[3].bounds.height * 0.75),
            points[3].rightAnchor.constraint(equalTo: rightAnchor, constant: points[3].bounds.height),
            
            points[4].centerYAnchor.constraint(equalTo: centerYAnchor),
            points[4].rightAnchor.constraint(equalTo: rightAnchor, constant: points[4].bounds.height),
            
            points[5].bottomAnchor.constraint(equalTo: bottomAnchor, constant: points[5].bounds.height * 0.75),
            points[5].rightAnchor.constraint(equalTo: rightAnchor, constant: points[5].bounds.height),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
