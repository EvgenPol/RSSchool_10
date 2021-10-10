//
//  GameResultViewController.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 30.08.2021.
//

import UIKit

final class GameResultViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellSectionOneID = "Top"
    let cellSectionTwoID = "Turns"
    let gameCounter = GameCounter.shared
    lazy var sortedPlayers = gameCounter.players.sorted { $0.score > $1.score }
   
    var topList = [(number: Int, points: Int)]()
    
    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController as? NavigationViewController {
            navigation.configureGameResultsViewController(self)
        }
        view.backgroundColor = .gameMainBackgroundColor
        createTopList()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigation = navigationController as? NavigationViewController
        navigation?.headerView.isHidden = true
        
        if gameCounter.isGameRestart {
            navigation?.popToRootViewController(animated: false)
            gameCounter.isGameRestart = false
        } else {
            tableView.reloadData()
        }
    }
    
    private func createTopList() {
        var currentNumber = 1
        var currenPoint = sortedPlayers.first!.score
        sortedPlayers.forEach { player in
            if player.score == currenPoint {
                topList += [(currentNumber, currenPoint)]
            } else {
                currentNumber += 1
                currenPoint = player.score
                topList += [(currentNumber, currenPoint)]
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GameResultTableCell.self, forCellReuseIdentifier: cellSectionOneID)
        tableView.register(GameResultTableCell.self, forCellReuseIdentifier: cellSectionTwoID)
        tableView.separatorStyle = .none
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

// MARK: - Table view data source
extension GameResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        gameCounter.moves.isEmpty ? 1 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return gameCounter.players.count
        case 1: return gameCounter.moves.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameResultTableCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: cellSectionOneID, for: indexPath) as! GameResultTableCell
            cell.setupForTopPlayers()
            
            let mutableString = NSMutableAttributedString(string: "#\(topList[indexPath.row].number) \(sortedPlayers[indexPath.row].name)",
                                                          attributes: [ .font : UIFont.nunito800(28)] )
            
            mutableString.addAttribute(.foregroundColor,
                                       value: UIColor.gameArrowButtonColor,
                                       range: NSRange(location:3, length: mutableString.length - 3))
            
            mutableString.addAttribute(.foregroundColor,
                                       value: UIColor.white,
                                       range: NSRange(location:0, length: 3))
              
            cell.textLabel?.attributedText = mutableString
            cell.rightLabel.text = String(topList[indexPath.row].points)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: cellSectionTwoID, for: indexPath) as! GameResultTableCell
            let indexPlayer = gameCounter.moves[indexPath.row].player.row
          
            cell.textLabel?.text = gameCounter.players[indexPlayer].name
            cell.rightLabel.text = gameCounter.moves[indexPath.row].points.turningIntoString()
            cell.setuForTurnsPlayers()
        }
        return cell
    }
}

extension GameResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ?  50 : 52
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView()
            view.backgroundColor = .gameSecondaryBackgroundColor
            view.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 15)
            
            let label = UILabel()
            view.addSubview(label)
            label.text = "Turns"
            label.textColor = .gameHeaderLabelTextColor
            label.font = .nunito600(16)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
                label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -15),
                label.heightAnchor.constraint(equalToConstant: 25)
            ])
            
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView()
            view.backgroundColor = .gameSecondaryBackgroundColor
            view.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 15)
            return view
        }
        return nil
    }
}

fileprivate extension Int {
    func turningIntoString() -> String {
        let str = String(self)
        if str.contains("-") {
            return str
        } else {
            return "+" + str
        }
    }
}
