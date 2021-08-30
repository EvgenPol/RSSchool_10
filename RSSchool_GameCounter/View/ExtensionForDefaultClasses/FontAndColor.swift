//
//  Font.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

extension UIFont {
    static func nunito600(_ size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-SemiBold", size: size)!
    }
    
    static func nunito700(_ size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-Bold", size: size)!
    }
    
    static func nunito800(_ size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-ExtraBold", size: size)!
    }
   
}

extension UIColor {
    static var gameMainBackgroundColor: UIColor {
        UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
    }
    
    static var gameSecondaryBackgroundColor: UIColor {
        UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
    }
    
    static var gameButtonColor: UIColor {
        UIColor(red: 132/255, green: 184/255, blue: 173/255, alpha: 1)
    }
    
    static var gameDiceBackgroundColor: UIColor {
        UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
    }
    
    static var gameProcessNamePlayerColor: UIColor {
        UIColor(red: 235/255, green: 174/255, blue: 104/255, alpha: 1)
    }
    
    static var gameButtonHighlightedColor: UIColor {
        UIColor(red: 84/255, green: 120/255, blue: 111/255, alpha: 1)
    }
    
    static var gameLetterColor: UIColor {
        UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
    }
    
    static var gameArrowButtonColor: UIColor {
        UIColor(red: 235/255, green: 174/255, blue: 104/255, alpha: 1)
    }
    
    static var gameSeparatorCellColor: UIColor {
        UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
    }
   
    static var gameHeaderLabelTextColor: UIColor {
        UIColor(red: 235/255, green: 235/255, blue: 245/255, alpha: 0.6)
    }
}
