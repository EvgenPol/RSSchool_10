//
//  BasisDice.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

enum SizeDice {
    case mini, standard
}
enum FaceOfDice: Int {
    case one, two, three, four, five, six
}

class BasisDice: UIButton {
    class DicePoint: UIView { }
    
    let faceOfDice: FaceOfDice
    let points: [DicePoint]
    
    static var dicesStandard : [BasisDice] = [
        DiceOne(size: .standard),
        DiceTwo(size: .standard),
        DiceThree(size: .standard),
        DiceFour(size: .standard),
        DiceFive(size: .standard),
        DiceSix(size: .standard),
     ]
    
    init(size: SizeDice, face: FaceOfDice, points: [DicePoint]) {
        faceOfDice = face
        self.points = points
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.gameSecondaryBackgroundColor.cgColor
        backgroundColor = .gameDiceBackgroundColor
        
        switch size {
        case .mini:
            layer.cornerRadius = 5
            layer.borderWidth = 1
            heightAnchor.constraint(equalToConstant: 30).isActive = true
            widthAnchor.constraint(equalToConstant: 30).isActive = true
        case .standard:
            layer.cornerRadius = 15
            layer.borderWidth = 4
            heightAnchor.constraint(equalToConstant: 120).isActive = true
            widthAnchor.constraint(equalToConstant: 120).isActive = true
        }
    }
    
    func createConstraintsForPoints(size: SizeDice) { }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BasisDice.DicePoint {
    convenience init(size: SizeDice) {
        self.init(frame: .zero)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
        switch size {
        case .mini:
            layer.cornerRadius = 3
            heightAnchor.constraint(equalToConstant: 6).isActive = true
            widthAnchor.constraint(equalToConstant: 6).isActive = true
        case .standard:
            layer.cornerRadius = 12
            heightAnchor.constraint(equalToConstant: 24).isActive = true
            widthAnchor.constraint(equalToConstant: 24).isActive = true
        }
        
    }
}
