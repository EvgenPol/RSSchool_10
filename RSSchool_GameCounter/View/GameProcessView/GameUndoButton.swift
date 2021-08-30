//
//  GameUndoButton.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 29.08.2021.
//

import UIKit

fileprivate typealias P = CGPoint
fileprivate extension CGPoint {
     init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y)
    }
}

class GameUndoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShapeLayer()
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 20).isActive = true
        heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    private func addShapeLayer() {
        let path = UIBezierPath.init()
        path.move(to: P(5,20))
        path.addCurve(to: P(0, 5), controlPoint1: P(22,20), controlPoint2: P(22,0))
        path.addLine(to: P(7,0))
        path.move(to: P(0,5))
        path.addLine(to: P(7,10))
       
        let shape = CAShapeLayer()
        shape.lineWidth = 3
        shape.path = path.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.gameLetterColor.cgColor
        shape.lineCap = .round
        shape.lineJoin = .round
        
        layer.addSublayer(shape)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
