//
//  AttributedString.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

extension NSAttributedString {
    static var atrributesForBarButton: [NSAttributedString.Key : Any] {
        [NSAttributedString.Key.foregroundColor : UIColor.gameButtonColor,
         NSAttributedString.Key.font : UIFont.nunito800(17)]
    }
    
    static var atrributesForNavigationLargeTitle: [NSAttributedString.Key : Any] {
        [NSAttributedString.Key.foregroundColor : UIColor.white,
         NSAttributedString.Key.font : UIFont.nunito800(36)]
    }
    
    static var atrributesForNavigationTitle: [NSAttributedString.Key : Any] {
        [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
