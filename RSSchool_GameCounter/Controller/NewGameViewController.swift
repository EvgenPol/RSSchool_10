//
//  ViewController.swift
//  RSSchool_GameCounter
//
//  Created by Евгений Полюбин on 25.08.2021.
//

import UIKit

class NewGameViewController: UIViewController {
    var gameCounter = GameCounter()
    let tableView = UITableView(frame: .zero, style: .grouped)
    var startButton = StartGameButton.init()
    let containerView = UIView()
    
    let barButtonCancel = UIBarButtonItem.init(title: "Cancel",
                                               style: .plain,
                                               target: self,
                                               action: #selector(tapCancel))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        tableView.register(GameCounterCell.self, forCellReuseIdentifier: "player")
        
        navigationItem.title = "Game Counter"
        
        view.backgroundColor = UIColor.init(named: "MainBackgroundColor")
        
        addConsTable()
        
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(containerView)
        view.addSubview(startButton)
        containerView.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navigationVC = navigationController else { return }
        if navigationVC.viewControllers.count > 1 {
            navigationItem.leftBarButtonItem = barButtonCancel
        }
        
    }
    override func viewWillLayoutSubviews() {
        startButton.addMask()
    }
    
    @objc private func tapCancel() {
        
    }
    
    private func addConsTable(){
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
            
        }
        cell.backgroundColor = UIColor(red: 59/255, green:  59/255, blue:  59/255, alpha: 1)
        return cell
    }
}

