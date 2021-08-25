//
//  NavigationViewController.swift
//  RSSchool_GameCounter
//
//  Created by Евгений Полюбин on 25.08.2021.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
       
        let font = UIFont(name: "Nunito-ExtraBold", size: 36.0)!
        navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.font: font,
                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
    
        navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
        navigationBar.barTintColor = UIColor.darkGray
    }
    
    
}

//extension UIFont {
//    static func printAll() {
//        familyNames.sorted().forEach { familyName in
//            print("*** \(familyName) ***")
//            fontNames(forFamilyName: familyName).sorted().forEach { fontName in
//                print("\(fontName)")
//            }
//            print("---------------------")
//        }
//    }
//}
