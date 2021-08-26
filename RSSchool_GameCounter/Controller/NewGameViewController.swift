//
//  ViewController.swift
//  RSSchool_GameCounter
//
//  Created by Евгений Полюбин on 25.08.2021.
//

import UIKit

class NewGameViewController: UIViewController {
    let gameCounter = GameCounter.shared
    let tableView = UITableView(frame: .zero, style: .grouped)
    let startButton = StartGameButton.init()
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(named: "MainBackgroundColor")
        startButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(pushGameProcess)))
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        tableView.register(GameCounterCell.self, forCellReuseIdentifier: "player")
        
        if let navigationVC = navigationController as? NavigationViewController {
            navigationVC.configureNewGameViewController(self)
        } else {
            createTabBarItemsForModal()
        }
        
        addConsTable()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(containerView)
        view.addSubview(startButton)
        containerView.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
       print(navigationController?.viewControllers.count)
    }
    
    override func viewWillLayoutSubviews() {
        startButton.setupMaskedTitle()
    }
    
    @objc private func tapCancel() {
        //TODO:
    }
    
    @objc private func pushGameProcess() {
        print("t")
        navigationController?.pushViewController(GameProcessViewController(),
                                                 animated: true)
    }
    
    private func createTabBarItemsForModal() {
        //TODO:
    }
    
    private func addConsTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
    
            startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
        ])
    }
}



//MARK: Working with Table View
extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
           return 120
        } else {
           return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == gameCounter.players.count {
            navigationController?.pushViewController(AddPlayerViewController(), animated: true)
        }
    }
}
    

extension NewGameViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameCounter.players.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: GameCounterCell
        
        if let tmpCell = tableView.dequeueReusableCell(withIdentifier: "player") {
            cell = tmpCell as! GameCounterCell
        } else {
            cell = GameCounterCell(style: .value2, reuseIdentifier: "player")
        }
        
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == gameCounter.players.count
        cell.configureCell(isFirstCell, isLastCell)
        
        if isLastCell {
            cell.title.text = "add players"
        } else {
            cell.title.text = gameCounter.players[indexPath.row].name
            cell.leftButton.addTarget(self, action: #selector(deletePlayer), for: .touchUpInside)
        }
        cell.leftButton.tag = indexPath.row
        cell.backgroundColor = UIColor(red: 59/255, green:  59/255, blue:  59/255, alpha: 1)
        cell.selectionStyle = .none
        return cell
    }
}

extension NewGameViewController {
    @objc private func tapAddPlayer() {
        navigationController?.pushViewController(AddPlayerViewController(), animated: true)
    }
    @objc private func deletePlayer(_ sender: UIButton) {
        print("tap")
        gameCounter.deletePlayer(with: sender.tag)
        tableView.reloadData()
    }
    
}
