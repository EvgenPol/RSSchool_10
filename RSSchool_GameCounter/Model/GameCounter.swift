//
//  GameCounter.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 25.08.2021.
//

import Foundation

class GameCounter {
    static let shared = GameCounter()
    var players: [Player]
    var gameTimer: Int
    var currentPlayer: Int
    var moves = [(player: IndexPath, points: Int)]()
    var isGameRun: Bool {
        didSet {
            if let dataIsGameRun = try? JSONEncoder().encode(isGameRun) {
                UserDefaults.standard.setValue(dataIsGameRun, forKey: "isGameRun")
            }
        }
    }
    
    private init() {
        if let dataPlayers = UserDefaults.standard.value(forKey: "players") as? Data,
           let dataTimer = UserDefaults.standard.value(forKey: "gameTimer") as? Data,
           let dataIsGameRun = UserDefaults.standard.value(forKey: "isGameRun") as? Data,
           let dataCurrentPlayer = UserDefaults.standard.value(forKey: "currentPlayer") as? Data,
           
           let players = try? JSONDecoder().decode([Player].self, from: dataPlayers),
           let gameTimer = try? JSONDecoder().decode(Int.self, from: dataTimer),
           let isGameRun = try? JSONDecoder().decode(Bool.self, from: dataIsGameRun),
           let currentPlayer = try? JSONDecoder().decode(Int.self, from: dataCurrentPlayer)
        {
            self.players = players
            self.gameTimer = gameTimer
            self.isGameRun = isGameRun
            self.currentPlayer = currentPlayer
        } else {
            players = []
            gameTimer = 0
            isGameRun = false
            currentPlayer = 0
        
            guard let dataPlayers = try? JSONEncoder().encode(players),
                  let dataTimer = try? JSONEncoder().encode(gameTimer),
                  
                  let dataCurrentPlayer = try? JSONEncoder().encode(currentPlayer)
            else { return }

            UserDefaults.standard.setValue(dataPlayers, forKey: "players")
            UserDefaults.standard.setValue(dataTimer, forKey: "gameTimer")
            UserDefaults.standard.setValue(dataCurrentPlayer, forKey: "currentPlayer")
            UserDefaults.standard.synchronize()
        }
    }
    
    private func updatePlayersUserDefault() {
        guard let dataPlayers = try? JSONEncoder().encode(players) else { return }
        UserDefaults.standard.setValue(dataPlayers, forKey: "players")
        UserDefaults.standard.synchronize()
    }
    
    @objc func addPlayer(with name: String) {
        players += [Player(name: name)]
        updatePlayersUserDefault()
    }
    
    @objc func deletePlayer(with index: Int) {
        players.remove(at: index)
        updatePlayersUserDefault()
    }
    
    func change(player: Int, to place: Int) {
        let movedPlayer = players.remove(at: player)
        players.insert(movedPlayer, at: place)
        updatePlayersUserDefault()
    }
    
    func updateScorePlayer(for player: Int, with score: Int) {
        players[player].score += score
        updatePlayersUserDefault()
    }
    
    func updateTimer(new time: Int) {
        gameTimer = time
        guard let dataTimer = try? JSONEncoder().encode(gameTimer) else { return }
        UserDefaults.standard.setValue(dataTimer, forKey: "gameTimer")
        UserDefaults.standard.synchronize()
    }
    
    func updateCurrentPlayer(_ player: Int) {
        currentPlayer = player
        guard let dataCurrentPlayer = try? JSONEncoder().encode(currentPlayer) else { return }
        UserDefaults.standard.setValue(dataCurrentPlayer, forKey: "currentPlayer")
        UserDefaults.standard.synchronize()
    }
    
    func restartGame() {
        moves = []
        for index in players.indices {
            players[index].score = 0
        }
        updateTimer(new: 0)
        updateCurrentPlayer(0)
        updatePlayersUserDefault()
    }
}



