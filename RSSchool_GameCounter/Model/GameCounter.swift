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
    var currentPlayer: IndexPath = IndexPath(row: 0, section: 0) //TODO
    var moves = [(player: IndexPath, points: Int)]()
    
    private init() {
        if let dataPlayers = UserDefaults.standard.value(forKey: "players") as? Data,
           let dataTimer = UserDefaults.standard.value(forKey: "gameTimer") as? Data,
           
           let players = try? JSONDecoder().decode([Player].self, from: dataPlayers),
           let gameTimer = try? JSONDecoder().decode(Int.self, from: dataTimer)
        {
            self.players = players
            self.gameTimer = gameTimer
        } else {
            players = []
            gameTimer = 0
        
            guard let dataPlayers = try? JSONEncoder().encode(players),
                  let dataTimer = try? JSONEncoder().encode(gameTimer)
            else { return }

            UserDefaults.standard.setValue(dataPlayers , forKey: "players")

            UserDefaults.standard.setValue(dataTimer , forKey: "gameTimer")
            UserDefaults.standard.synchronize()
        }
    }
    
    private func updatePlayersUserDefault() {
        guard let dataPlayers = try? JSONEncoder().encode(players) else { return }
        UserDefaults.standard.setValue(dataPlayers, forKey: "players")
        UserDefaults.standard.synchronize()
    }
    
    private func updateTimerUserDefault() {
        guard let dataTimer = try? JSONEncoder().encode(gameTimer) else { return }
        UserDefaults.standard.setValue(dataTimer, forKey: "gameTimer")
        UserDefaults.standard.synchronize()
    }
    
    @objc func addPlayer(with name: String) {
        print("addPlayer")
        players += [Player(name: name)]
        updatePlayersUserDefault()
    }
    
    @objc func deletePlayer(with index: Int) {
        print("deletePlayer")
        players.remove(at: index)
        updatePlayersUserDefault()
    }
    
    func change(player: Int, to place: Int) {
        //TODO
        updatePlayersUserDefault()
    }
    
    func updateScorePlayer(for player: Int, with score: Int) {
        players[player].score += score
        updatePlayersUserDefault()
    }
    
    func updateTimer(new time: Int) {
        gameTimer = time
        updateTimerUserDefault()
    }
}



