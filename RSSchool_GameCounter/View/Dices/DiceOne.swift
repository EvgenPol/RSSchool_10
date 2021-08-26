//
//  DiceOne.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class DiceOne: BasisDice {
    init(size: SizeDice) {
        super.init(size: size, face: .one)
        let onePoint = BasisDice.DicePoint.init(size: size)
        addSubview(onePoint)
        onePoint.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        onePoint.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

