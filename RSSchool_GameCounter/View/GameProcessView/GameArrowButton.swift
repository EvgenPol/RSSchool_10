//
//  GameArrowButton.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 28.08.2021.
//

import UIKit

enum TypeGameArrowButton {
    case left, right
}

final class GameArrowButton: UIButton {
    var layerWithArrowBlock: CAShapeLayer!
    var type: TypeGameArrowButton

    init(type: TypeGameArrowButton){
        self.type = type
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 30),
            widthAnchor.constraint(equalToConstant: 32),
        ])
        
        
        switch type {
        case .left: buildLeftArrow()
        case .right: buildRightArrow()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeArrowHide() {
        if layerWithArrowBlock.isHidden {
            layerWithArrowBlock.isHidden = false
        } else {
            layerWithArrowBlock.isHidden = true
        }
    }
    
    private func buildRightArrow() {
        let layerRightArrowhead = CAShapeLayer()
        layerRightArrowhead.path = UIBezierPath.rightArrowhead.cgPath
        setupLayer(layerRightArrowhead, isRounded: true)
        
        let layerArrowBody = CAShapeLayer()
        layerArrowBody.path = UIBezierPath.arrowBody.cgPath
        setupLayer(layerArrowBody, isRounded: false)
        
        let layerRightBlock = CAShapeLayer()
        layerRightBlock.path = UIBezierPath.rightArrowBlock.cgPath
        setupLayer(layerRightBlock, isRounded: true)
        layerWithArrowBlock = layerRightBlock
        layerWithArrowBlock.isHidden = true
    }
    
    private func buildLeftArrow() {
        let layerLeftArrowhead = CAShapeLayer()
        layerLeftArrowhead.path = UIBezierPath.leftArrowhead.cgPath
        setupLayer(layerLeftArrowhead, isRounded: true)
        
        let layerArrowBody = CAShapeLayer()
        layerArrowBody.path = UIBezierPath.arrowBody.cgPath
        setupLayer(layerArrowBody, isRounded: false)
        
        let layerLeftBlock = CAShapeLayer()
        layerLeftBlock.path = UIBezierPath.leftArrowBlock.cgPath
        setupLayer(layerLeftBlock, isRounded: true)
        layerWithArrowBlock = layerLeftBlock
    }
    
    private func setupLayer(_ layer: CAShapeLayer, isRounded: Bool) {
        self.layer.addSublayer(layer)
        layer.strokeColor = UIColor.gameArrowButtonColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 6
        
        if isRounded {
            layer.lineJoin = .round
            layer.lineCap = .round
        }
    }
}

fileprivate extension UIBezierPath {
    static var rightArrowhead: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(15,0))
        path.addLine(to: CGPoint(30,15))
        path.addLine(to: CGPoint(15,30))
        return path
    }
    
    static var rightArrowBlock: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(33,0))
        path.addLine(to: CGPoint(33,30))
        return path
    }
    
    static var leftArrowhead: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(15,0))
        path.addLine(to: CGPoint(0,15))
        path.addLine(to: CGPoint(15,30))
        return path
    }
    
    static var leftArrowBlock: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(-3,0))
        path.addLine(to: CGPoint(-3,30))
        return path
    }
    
    static var arrowBody: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(32,15))
        path.addLine(to: CGPoint(2,15))
        return path
    }
}
