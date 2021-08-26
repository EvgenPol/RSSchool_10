//
//  GameCounter.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 25.08.2021.
//

import Foundation

class GameCounter {
    var players: [Player]
    
    init() {
        if let data = UserDefaults.standard.value(forKey: "players") as? Data,
           let players = try? JSONDecoder().decode([Player].self, from: data) {
            print(players)
            self.players = players
        } else {
            players = [Player(name: "Kate")]
            guard let data = try? JSONEncoder().encode(players) else { return }
            print(data)
            UserDefaults.standard.setValue(data , forKey: "players")
        }
    }
    
    func addPlayer(with name: String) {
        players += [Player(name: name)]
    }
    
    func change(player: Int, to place: Int) {
        //TODO
    }
    
}
