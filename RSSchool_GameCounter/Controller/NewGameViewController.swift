//
//  ViewController.swift
//  RSSchool_GameCounter
//
//  Created by Евгений Полюбин on 25.08.2021.
//

import UIKit

final class NewGameViewController: UIViewController {
    let gameCounter = GameCounter.shared
    let tableView = UITableView(frame: .zero, style: .grouped)
    let startButton = StartGameButton.init()
    let containerView = UIView()
    var temporaryPlayersList = [Player]()
    let cellPlayerID = "player"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gameMainBackgroundColor
        startButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(tapStartGameButton)))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.register(GameCounterCell.self, forCellReuseIdentifier: cellPlayerID)
        tableView.isEditing = true
        tableView.showsVerticalScrollIndicator = false
        
        
        if let navigationVC = navigationController as? NavigationViewController {
            navigationVC.configureNewGameViewController(self, isGameRun: gameCounter.isGameRun)
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
    }
    
    override func viewWillLayoutSubviews() {
        startButton.setupMaskedTitle()
    }
    
    
    @objc private func tapStartGameButton() {
        guard !gameCounter.players.isEmpty else {
            let alert = UIAlertController(title: "Ошибка!", message: "Нужен как минимум один игрок", preferredStyle: .alert)
            let viewAlert = alert.view.subviews.first?.subviews.first?.subviews.first
            viewAlert?.backgroundColor = .gameSecondaryBackgroundColor
            viewAlert?.layer.borderWidth = 3
            viewAlert?.layer.borderColor = UIColor.black.cgColor
            alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [weak self] _ in
                self?.startButton.viewTitle.backgroundColor = .gameButtonColor
            })
            present(alert, animated: true, completion: nil)
            return
        }
        
        gameCounter.restartGame()
        
        if gameCounter.isGameRun {
            gameCounter.isGameRestart = true
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.pushViewController(GameProcessViewController(), animated: true)
            gameCounter.isGameRun = true
            navigationController?.viewControllers.removeFirst()
        }
    }
    
    private func addConsTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: startButton.centerYAnchor),
            
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



//MARK: - TableView Delegate
extension NewGameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == gameCounter.players.count {
            navigationController?.pushViewController(AddPlayerViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
  
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
}
    

//MARK: - TableView DataSouce
extension NewGameViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameCounter.players.count
    }

    //tableView configure cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: GameCounterCell
        
        if let tmpCell = tableView.dequeueReusableCell(withIdentifier: cellPlayerID) {
            cell = tmpCell as! GameCounterCell
        } else {
            cell = GameCounterCell(style: .value2, reuseIdentifier: cellPlayerID)
        }
        
        cell.configureCell()
        cell.title.text = gameCounter.players[indexPath.row].name
        cell.leftButton.addTarget(self, action: #selector(deletePlayer), for: .touchUpInside)
        
        cell.leftButton.tag = indexPath.row
        cell.backgroundColor = UIColor(red: 59/255, green:  59/255, blue:  59/255, alpha: 1)
        cell.selectionStyle = .none
        return cell
    }
    
    //TableView Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        view.addSubview(label)
        label.text = "Players"
        label.font = .nunito600(16)
        label.textColor = .gameHeaderLabelTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor,constant: 15),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15),
            label.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        view.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 15)
        view.backgroundColor = .gameSecondaryBackgroundColor
        return view
    }
    
    //TableView Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = NewGameAddFooter()
        footer.addTarget(self, action: #selector(tapAddPlayer), for: .touchUpInside)
        return footer
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        gameCounter.change(player: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
}

//MARK: - tap buttons in cell

extension NewGameViewController {
    @objc private func tapAddPlayer() {
        navigationController?.pushViewController(AddPlayerViewController(), animated: true)
    }

    @objc private func deletePlayer(_ sender: UIButton) {
        gameCounter.deletePlayer(with: sender.tag)
        tableView.reloadData()
    }
}
