//
//  GameUndoButton.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 29.08.2021.
//

import UIKit
extension CGPoint {
     init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y)
    }
}

final class GameUndoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShapeLayer()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 20),
            heightAnchor.constraint(equalToConstant: 22)
        ])
       
    }
    
    private func addShapeLayer() {
        let path = UIBezierPath.init()
        path.move(to: CGPoint(5,20))
        path.addCurve(to: CGPoint(0, 5), controlPoint1: CGPoint(22,20), controlPoint2: CGPoint(22,0))
        path.addLine(to: CGPoint(7,0))
        path.move(to: CGPoint(0,5))
        path.addLine(to: CGPoint(7,10))
       
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
