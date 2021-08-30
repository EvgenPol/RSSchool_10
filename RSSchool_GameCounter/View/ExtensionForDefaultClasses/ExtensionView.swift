//
//  ExtensionView.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 30.08.2021.
//

import UIKit

extension UIView {
   func roundCorners(corners: CACornerMask, radius: CGFloat) {
    clipsToBounds = true
    layer.cornerRadius = radius
    layer.maskedCorners = corners
    }
}
