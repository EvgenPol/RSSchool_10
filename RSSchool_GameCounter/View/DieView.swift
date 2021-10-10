//
//  BasisDie.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

enum SizeDie {
    case mini, standard
}
enum FaceDie: Int {
    case one, two, three, four, five, six
}


final class DieView: UIButton {
  fileprivate final class DiePoint: UIView { }
    
    private let pointViews: [DiePoint]
    private var _faceDie = FaceDie.one
    var faceDie: FaceDie {
        get {
            _faceDie
        }
        set {
            _faceDie = newValue
            setupDiePoints(face: _faceDie)
        }
    }
    
    static var dieStandard = DieView(size: .standard)
    static var dieMini = DieView(size: .mini)
    
    private init(size: SizeDie) {
        pointViews = [
            DiePoint(size: size),
            DiePoint(size: size),
            DiePoint(size: size),
            DiePoint(size: size),
            DiePoint(size: size),
            DiePoint(size: size),
            DiePoint(size: size),
        ]
        print(pointViews.count)
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.gameSecondaryBackgroundColor.cgColor
        backgroundColor = .gameDiceBackgroundColor
        pointViews.forEach{ addSubview($0) }
        setupDiePoints(face: .one)
        
        switch size {
        case .mini:
            layer.cornerRadius = 5
            layer.borderWidth = 1
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: 30),
                widthAnchor.constraint(equalToConstant: 30),
            ])
        case .standard:
            layer.cornerRadius = 15
            layer.borderWidth = 4
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: 120),
                widthAnchor.constraint(equalToConstant: 120),
            ])
        }
        createConstraintsForPoints(size: size)
    }
    
    private func setupDiePoints(face: FaceDie) {
        switch face {
        case .one:
            pointViews.forEach{ $0.isHidden = true }
            pointViews[6].isHidden = false
        case .two:
            pointViews.forEach{ $0.isHidden = true }
            pointViews[0].isHidden = false
            pointViews[5].isHidden = false
        case .three:
            pointViews.forEach{ $0.isHidden = true }
            pointViews[0].isHidden = false
            pointViews[6].isHidden = false
            pointViews[5].isHidden = false
        case .four:
            pointViews.forEach{ $0.isHidden = false }
            pointViews[1].isHidden = true
            pointViews[4].isHidden = true
            pointViews[6].isHidden = true
        case .five:
            pointViews.forEach{ $0.isHidden = false }
            pointViews[1].isHidden = true
            pointViews[4].isHidden = true
        case .six:
            pointViews.forEach{ $0.isHidden = false }
            pointViews[6].isHidden = true
        }
    }
    
    private func createConstraintsForPoints(size: SizeDie) {
        let constant: CGFloat
        switch size {
        case .mini: constant = 6
        case .standard: constant = 24
        }
        
        NSLayoutConstraint.activate([
            pointViews[0].topAnchor.constraint(equalTo: topAnchor, constant: constant * 0.75),
            pointViews[0].leftAnchor.constraint(equalTo: leftAnchor, constant: constant),
        
            pointViews[1].centerYAnchor.constraint(equalTo: centerYAnchor),
            pointViews[1].leftAnchor.constraint(equalTo: leftAnchor, constant: constant),
            
            pointViews[2].bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant * 0.75),
            pointViews[2].leftAnchor.constraint(equalTo: leftAnchor, constant: constant),
            
            pointViews[3].topAnchor.constraint(equalTo: topAnchor, constant: constant * 0.75),
            pointViews[3].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant),
            
            pointViews[4].centerYAnchor.constraint(equalTo: centerYAnchor),
            pointViews[4].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant),
            
            pointViews[5].bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant * 0.75),
            pointViews[5].rightAnchor.constraint(equalTo: rightAnchor, constant: -constant),
            
            pointViews[6].centerYAnchor.constraint(equalTo: centerYAnchor),
            pointViews[6].centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - class DiePoint
fileprivate extension DieView.DiePoint {
    convenience init(size: SizeDie) {
        self.init(frame: .zero)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        
        switch size {
        case .mini:
            layer.cornerRadius = 3
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: 6),
                widthAnchor.constraint(equalToConstant: 6)
            ])
        case .standard:
            layer.cornerRadius = 12
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: 24),
                widthAnchor.constraint(equalToConstant: 24)
            ])
        }
    }
}
