//
//  GameCounterCell.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 25.08.2021.
//

import UIKit

class GameCounterCell: UITableViewCell {
    private var header: UILabel?
    var leftButton: GameCounterCellButton!
    var rightButton : UIButton?
    let title = UILabel()
    
    func configureCell(_ isFirstCell: Bool,_ isLastCell: Bool) {
        if isFirstCell { configureFirstCell() }
        isLastCell ? configureLastCell() : configureDefaultCell()
        backgroundColor = UIColor.init(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        addCons()
    }
    
    private func configureFirstCell() {
        let head = UILabel()
        head.text = "Players"
        head.textColor = UIColor(red: 235/255, green: 235/255, blue: 245/255, alpha: 0.6)
        head.font = UIFont.nunito600(16)
        head.translatesAutoresizingMaskIntoConstraints = false
        header = head
        addSubview(head)
        roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 15)
    }
    
    private func configureDefaultCell() {
        leftButton = GameCounterCellButton().createLeftButton(type: .delete)
        let rightButton = GameCounterCellButton().createRightButton()
        self.rightButton = rightButton
        title.textColor = .white
        title.font = UIFont.nunito800(20)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(title)
    }
    
    private func configureLastCell() {
        leftButton = GameCounterCellButton().createLeftButton(type: .add)
        title.textColor = UIColor(red: 132/255, green: 184/255, blue: 173/255, alpha: 1)
        title.font = UIFont.nunito600(16)
        addSubview(leftButton)
        addSubview(title)
        roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 15)
    }
    
    private func addCons() {
        title.translatesAutoresizingMaskIntoConstraints = false
     
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            title.leftAnchor.constraint(equalTo: leftButton.rightAnchor, constant: 15),
            title.centerYAnchor.constraint(equalTo: leftButton.centerYAnchor),
        ])
        
        if let head = header {
            head.translatesAutoresizingMaskIntoConstraints = false
            head.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
            head.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        }
        
        if let rightButton = rightButton {
            rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
            rightButton.centerYAnchor.constraint(equalTo: leftButton.centerYAnchor).isActive = true
        }
        
    }
}

extension UIView {
   func roundCorners(corners: CACornerMask, radius: CGFloat) {
    clipsToBounds = true
    layer.cornerRadius = radius
    layer.maskedCorners = corners
    }
}
