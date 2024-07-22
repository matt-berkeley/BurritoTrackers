//
//  Bettor.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//

import Foundation
import SwiftData

//@Model
//class Bettor: Identifiable {
//    var id: UUID
//    var name: String
//    var wins: Int
//    var losses: Int
//    var bets: [Bet] = []
//    
//    init(id: UUID = UUID(), name: String, wins: Int = 0, losses: Int = 0, bets: [Bet] = []) {
//        self.id = id
//        self.name = name
//        self.wins = wins
//        self.losses = losses
//        self.bets = bets
//    }
//    
//    // Compute net burritos from the bets
//    var netBurritos: Int {
//        let totalBurritosEarned = bets.filter { $0.winner?.id == id }.reduce(0) { $0 + $1.wagerAmount }
//        let totalBurritosLost = bets.filter { $0.winner?.id != id && $0.winner != nil }.reduce(0) { $0 + $1.wagerAmount }
//        return totalBurritosEarned - totalBurritosLost
//    }
//    
//    // Function to update wins and losses based on a bet's outcome
//    func updateRecord(for bet: Bet, isWin: Bool) {
//        if isWin {
//            wins += 1
//        } else {
//            losses += 1
//        }
//    }
//}

@Model
class Bettor {
    var id: UUID
    var name: String

    var bets: [Bet] = []
    
    var wins: Int {
        // Compute number of wins based on related bets
        bets.filter { $0.winner?.id == id }.count
    }
    
    var losses: Int {
        // Compute number of losses based on related bets
        bets.filter { $0.winner?.id != id && $0.winner != nil }.count
    }
    
    init(id: UUID = UUID(), name: String, bets: [Bet] = []) {
        self.id = id
        self.name = name
        self.bets = bets
    }
}
