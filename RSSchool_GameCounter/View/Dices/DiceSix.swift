//
//  DiceSix.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class DiceSix: BasisDice {
    init(size: SizeDice) {
        let points = [BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size)]
        
        super.init(size: size, face: .six, points: points)
        points.forEach { addSubview($0) }
        createConstraintsForPoints(size: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func createConstraintsForPoints(size: SizeDice) {
        let constant: CGFloat
        switch size {
        case .mini: constant = 6
        case .standard: constant = 24
        }
        
        NSLayoutConstraint.activate([
            points[0].topAnchor.constraint(equalTo: topAnchor, constant: constant * 0.75),
            points[0].leftAnchor.constraint(equalTo: leftAnchor, constant: constant),
        
            points[1].centerYAnchor.constraint(equalTo: centerYAnchor),
            points[1].leftAnchor.constraint(equalTo: leftAnchor, constant: constant),
            
            points[2].bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant * 0.75),
            points[2].leftAnchor.constraint(equalTo: leftAnchor, constant: constant),
            
            points[3].topAnchor.constraint(equalTo: topAnchor, constant: constant * 0.75),
            points[3].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant),
            
            points[4].centerYAnchor.constraint(equalTo: centerYAnchor),
            points[4].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant),
            
            points[5].bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant * 0.75),
            points[5].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant),
        ])
    }
}
