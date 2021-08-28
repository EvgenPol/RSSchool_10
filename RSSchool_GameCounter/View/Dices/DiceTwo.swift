//
//  DiceTwo.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class DiceTwo: BasisDice {
    init(size: SizeDice) {
        let points = [BasisDice.DicePoint.init(size: size),
                      BasisDice.DicePoint.init(size: size)]
        
        super.init(size: size, face: .one, points: points)
        points.forEach { addSubview($0) }
        createConstraintsForPoints(size: size)
    }
    
    override func createConstraintsForPoints(size: SizeDice) {
        let constant: CGFloat
        switch size {
        case .mini: constant = 6
        case .standard: constant = 24
        }
        
        NSLayoutConstraint.activate([
            points[0].topAnchor.constraint(equalTo: topAnchor, constant: constant),
            points[0].leftAnchor.constraint(equalTo: leftAnchor, constant: constant),
            
            points[1].bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant),
            points[1].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
