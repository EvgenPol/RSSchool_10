//
//  GameCounter.swift
//  RSSchool_GameCounter
//
//  Created by Evgeniy Polyubin on 25.08.2021.
//

import Foundation

final class GameCounter {
    enum UserDefaultsKeys: String {
        case isGameRun, players, gameTimer, currentPlayerIndex
    }
    
    static let shared = GameCounter()
    
    var jsonDecoder = JSONDecoder()
    var jsonEncoder = JSONEncoder()
    var userDefaults = UserDefaults.standard
    var players: [Player]
    var gameTimer: Int
    var currentPlayerIndex: Int
    var moves = [(player: IndexPath, points: Int)]()
    var isGameRun: Bool {
        didSet {
            if let dataIsGameRun = try? jsonEncoder.encode(isGameRun) {
                userDefaults.setValue(dataIsGameRun, forKey: UserDefaultsKeys.isGameRun.rawValue)
            }
        }
    }
    
    private init() {
        gameTimer = userDefaults.integer(forKey: UserDefaultsKeys.gameTimer.rawValue)
        isGameRun = userDefaults.bool(forKey: UserDefaultsKeys.isGameRun.rawValue)
        currentPlayerIndex = userDefaults.integer(forKey: UserDefaultsKeys.currentPlayerIndex.rawValue)
        
        if let dataPlayers = userDefaults.value(forKey: UserDefaultsKeys.players.rawValue) as? Data,
           let players = try? jsonDecoder.decode([Player].self, from: dataPlayers) {
            self.players = players
        } else {
            self.players = []
            guard let dataPlayers = try? jsonEncoder.encode(players) else {
                assertionFailure("Error with encode players")
                return
            }
            userDefaults.setValue(dataPlayers, forKey: UserDefaultsKeys.players.rawValue)
            userDefaults.setValue(gameTimer, forKey: UserDefaultsKeys.gameTimer.rawValue)
            userDefaults.setValue(currentPlayerIndex, forKey: UserDefaultsKeys.currentPlayerIndex.rawValue)
            userDefaults.synchronize()
        }
    }
    
    private func updatePlayersUserDefault() {
        guard let dataPlayers = try? jsonEncoder.encode(players) else {
            assertionFailure()
            return
        }
        userDefaults.setValue(dataPlayers, forKey: UserDefaultsKeys.players.rawValue)
        userDefaults.synchronize()
    }
    
    func addPlayer(with name: String) {
        players += [Player(name: name)]
        updatePlayersUserDefault()
    }
    
    func deletePlayer(with index: Int) {
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
        guard let dataTimer = try? jsonEncoder.encode(gameTimer) else {
            assertionFailure()
            return
        }
        userDefaults.setValue(dataTimer, forKey: UserDefaultsKeys.gameTimer.rawValue)
        userDefaults.synchronize()
    }
    
    func updateCurrentPlayer(index player: Int) {
        currentPlayerIndex = player
        guard let dataCurrentPlayer = try? jsonEncoder.encode(currentPlayerIndex) else {
            assertionFailure()
            return
        }
        userDefaults.setValue(dataCurrentPlayer, forKey: UserDefaultsKeys.currentPlayerIndex.rawValue)
        userDefaults.synchronize()
    }
    
    func restartGame() {
        moves = []
        for index in players.indices {
            players[index].score = 0
        }
        updateTimer(new: 0)
        updateCurrentPlayer(index: 0)
        updatePlayersUserDefault()
    }
}



