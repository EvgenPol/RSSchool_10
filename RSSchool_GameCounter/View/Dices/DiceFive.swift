//
//  D.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class DiceFive: BasisDice {
    init(size: SizeDice) {
        let points = [BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size)]
        
        super.init(size: size, face: .five, points: points)
        points.forEach { addSubview($0) }
        createConstraintsForPoints(size: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func createConstraintsForPoints(size: SizeDice) {
        let constant: CGFloat
        switch size {
        case .mini: constant = 30
        case .standard: constant = 120
        }
        
        NSLayoutConstraint.activate([
            points[0].topAnchor.constraint(equalTo: topAnchor, constant: constant/6),
            points[0].leftAnchor.constraint(equalTo: leftAnchor, constant: constant/6),
            
            points[1].topAnchor.constraint(equalTo: topAnchor, constant: constant/6),
            points[1].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant/6),
            
            points[2].bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant/6),
            points[2].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant/6),
            
            points[3].bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant/6),
            points[3].leftAnchor.constraint(equalTo: leftAnchor, constant: constant/6),
            
            points[4].centerXAnchor.constraint(equalTo: centerXAnchor),
            points[4].centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
