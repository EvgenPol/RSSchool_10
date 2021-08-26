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
    
    private init() {
        if let data = UserDefaults.standard.value(forKey: "players") as? Data,
           let players = try? JSONDecoder().decode([Player].self, from: data) {
            print(players)
            self.players = players
        } else {
            players = []
            guard let data = try? JSONEncoder().encode(players) else { return }

            UserDefaults.standard.setValue(data , forKey: "players")
        }
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
    
    private func updateUserDefault() {
        guard let data = try? JSONEncoder().encode(players) else { return }
        UserDefaults.standard.setValue(data, forKey: "players")
        UserDefaults.standard.synchronize()
    }
    
    func change(player: Int, to place: Int) {
        //TODO
    }
    
}
