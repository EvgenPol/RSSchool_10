//
//  AddPlayerViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 26.08.2021.
//

import UIKit

class AddPlayerViewController: UIViewController {
    var textField: UITextField!
    let gameCounter = GameCounter.shared
    var playerName = "" {
        didSet {
            if playerName.isEmpty {
                navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }

    
    override func loadView() {
        super.loadView()
        textField = UITextField()
        view.addSubview(textField)
        configureTextField()
        view.backgroundColor = UIColor.gameMainBackgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController as? NavigationViewController {
            navigation.configureAddPlayerViewController(self)
            navigationItem.rightBarButtonItem?.target = self
            navigationItem.rightBarButtonItem?.action = #selector(addPlayer)
        }
    }
    
    @objc private func addPlayer() {
        gameCounter.addPlayer(with: playerName)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func configureTextField() {
        let width = UIScreen.main.bounds.width
        textField.frame = CGRect(x: 0, y: 160, width: width, height: 60)
        textField.backgroundColor = UIColor.gameSecondaryBackgroundColor
        textField.attributedPlaceholder = NSAttributedString.forPlaceholder
        textField.font = UIFont.nunito800(24)
        textField.textColor = .white
        textField.placeholder = "Player Name"
        textField.keyboardType = .asciiCapable
        textField.keyboardAppearance = .dark
        textField.addTarget(self, action: #selector(changeName), for: .editingChanged)
        textField.autocorrectionType = .no
        textField.tintColor = .white
        textField.delegate = self
      
        //for text insets without subclasses
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: 60))
        leftView.backgroundColor = textField.backgroundColor;
        textField.leftView = leftView;
        textField.leftViewMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playerName = ""
        textField.becomeFirstResponder()
    }
    
    @objc private func changeName() {
        guard let txt = textField.text else { return }
        playerName = txt
    }
}
    



//MARK: TextField delegate
extension AddPlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if !playerName.isEmpty {
            addPlayer()
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        true
    }
}

extension NSAttributedString {
    static var forPlaceholder: NSAttributedString {
        let color = UIColor(red: 155/255, green: 155/255, blue: 161/255, alpha: 1)
        return NSAttributedString(string: "Player name",
                                  attributes: [
                                    NSAttributedString.Key.foregroundColor : color,
                                    NSAttributedString.Key.font : UIFont.nunito800(20)
                                  ])
    }
}
