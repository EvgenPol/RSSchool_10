//
//  GameCounterCellButton.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 25.08.2021.
//

import UIKit

enum GameCounterCellButtonSide {
    case left, right
}

enum GameCounterCellButtonType {
    case add, delete
}

class GameCounterCellButton: UIButton { }



//MARK: Methods for create left button

extension GameCounterCellButton {
    func createLeftButton(type: GameCounterCellButtonType) -> GameCounterCellButton  {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25/2
        heightAnchor.constraint(equalToConstant: 25).isActive = true
        widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        if type == .delete {
           createMinus()
        } else {
           createPlus()
        }
        return self
    }
    
    private func createMinus() {
        let stick = UIView()
        stick.backgroundColor = .white
        stick.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.init(red: 236/255, green: 94/255, blue: 96/255, alpha: 1)
        
        addSubview(stick)
        NSLayoutConstraint.activate([
            stick.widthAnchor.constraint(equalToConstant: 12),
            stick.heightAnchor.constraint(equalToConstant: 1),
            stick.centerYAnchor.constraint(equalTo: centerYAnchor),
            stick.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func createPlus() {
        backgroundColor = UIColor.init(red: 132/255, green: 184/255, blue: 173/255, alpha: 1)
        
        let horizontalStick = UIView()
        horizontalStick.backgroundColor = .white
        horizontalStick.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalStick)
        
        let verticalStick = UIView()
        verticalStick.backgroundColor = .white
        verticalStick.translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStick)
        
        NSLayoutConstraint.activate([
            horizontalStick.widthAnchor.constraint(equalToConstant: 8),
            horizontalStick.heightAnchor.constraint(equalToConstant: 1),
            horizontalStick.centerYAnchor.constraint(equalTo: centerYAnchor),
            horizontalStick.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            verticalStick.widthAnchor.constraint(equalToConstant: 1),
            verticalStick.heightAnchor.constraint(equalToConstant: 8),
            verticalStick.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStick.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}



//MARK: methods for create right button

extension GameCounterCellButton {
     func createRightButton() -> GameCounterCellButton {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        func createStick() -> UIView {
            let stick = UIView()
            stick.translatesAutoresizingMaskIntoConstraints = false
            stick.heightAnchor.constraint(equalToConstant: 2).isActive = true
            stick.backgroundColor = UIColor.white
            stick.layer.cornerRadius = 0.5
            addSubview(stick)
            return stick
        }
        
        let stickOne = createStick()
        let stickTwo = createStick()
        let stickThree = createStick()
      
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 12),
            widthAnchor.constraint(equalToConstant: 20),
            
            stickOne.leftAnchor.constraint(equalTo: leftAnchor),
            stickOne.rightAnchor.constraint(equalTo: rightAnchor),
            stickOne.bottomAnchor.constraint(equalTo: bottomAnchor),


            stickTwo.leftAnchor.constraint(equalTo: leftAnchor),
            stickTwo.rightAnchor.constraint(equalTo: rightAnchor),
            stickTwo.centerYAnchor.constraint(equalTo: centerYAnchor),

            stickThree.leftAnchor.constraint(equalTo: leftAnchor),
            stickThree.rightAnchor.constraint(equalTo: rightAnchor),
            stickThree.topAnchor.constraint(equalTo: topAnchor),
            
        ])
        
        return self
    }
}

