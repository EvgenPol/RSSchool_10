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
    var playersMoves: [(player: Int, point: Int)]
    
    private init() {
        if let dataPlayers = UserDefaults.standard.value(forKey: "players") as? Data,
           let dataMovesPoints = UserDefaults.standard.value(forKey: "movesPoints") as? Data,
           let dataMovesPlayers = UserDefaults.standard.value(forKey: "movesPlayers") as? Data,
           
           let players = try? JSONDecoder().decode([Player].self, from: dataPlayers),
           let movesPlayers = try? JSONDecoder().decode([Int].self, from: dataMovesPlayers),
           let movesPoints = try? JSONDecoder().decode([Int].self, from: dataMovesPoints)
        {
            self.players = players
            self.playersMoves = {
                var array = [(Int,Int)]()
                movesPlayers.indices.forEach { index in
                    array += [(movesPlayers[index], movesPoints[index])]
                }
                return array
            }()
            print(self.players.count)
            print(playersMoves.count)
            
        } else {
            players = []
            playersMoves = []
            let movesPlayers = [Int]()
            let movesPoints = [Int]()
            
            guard let dataPlayers = try? JSONEncoder().encode(players),
                  let dataMovesPlayers = try? JSONEncoder().encode(movesPlayers),
                  let dataMovesPoints = try? JSONEncoder().encode(movesPoints)
            else { return }

            UserDefaults.standard.setValue(dataPlayers , forKey: "players")
            UserDefaults.standard.setValue(dataMovesPlayers , forKey: "movesPlayers")
            UserDefaults.standard.setValue(dataMovesPoints , forKey: "movesPoints")
            UserDefaults.standard.synchronize()
        }
    }
    
    private func updateUserDefault() {
        var movesPlayers: [Int] = []
        var movesPoints: [Int] = []
        
        playersMoves.forEach { (player: Int, point: Int) in
            movesPlayers += [player]
            movesPoints += [point]
        }
        
        guard let dataPlayers = try? JSONEncoder().encode(players),
              let dataMovesPlayers = try? JSONEncoder().encode(movesPlayers),
              let dataMovesPoints = try? JSONEncoder().encode(movesPoints)
        else { return }
        
        UserDefaults.standard.setValue(dataPlayers, forKey: "players")
        UserDefaults.standard.setValue(dataMovesPlayers , forKey: "movesPlayers")
        UserDefaults.standard.setValue(dataMovesPoints , forKey: "movesPoints")
        UserDefaults.standard.synchronize()
    }
    
    @objc func addPlayer(with name: String) {
        print("addPlayer")
        players += [Player(name: name)]
        updateUserDefault()
    }
    
    @objc func deletePlayer(with index: Int) {
        print("deletePlayer")
        players.remove(at: index)
        updateUserDefault()
    }
    
    func change(player: Int, to place: Int) {
        //TODO
    }
    
    func updateScorePlayer(for player: Int, with score: Int) {
        players[player].score += score
        playersMoves += [(player, score)]
        updateUserDefault()
    }
    
    func addMovePlayer(_ move: (player: Int, point: Int)) {
        playersMoves += [move]
        updateUserDefault()
    }
    
    func deleteMovePlayer() -> (player: Int, point: Int) {
        let move = playersMoves.removeLast()
        updateUserDefault()
        return move
    }
    
}



