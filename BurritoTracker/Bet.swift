//
//  Bet.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//


import Foundation
import SwiftData

@Model
class Bet {
    var id: UUID
    var betDescription: String
    var wagerAmount: Int
    @Relationship(inverse: \Bettor.bets)
    var bettors: [Bettor] = []
    var winner: Bettor?
    var isPaidOut: Bool
    var isCompleted: Bool {
        if winner != nil && isPaidOut == true {
            return true
        }
        else {
            return false
        }
    }
    var date: Date
    
    init(id: UUID = UUID(), betDescription: String, wagerAmount: Int, bettors: [Bettor] = [], winner: Bettor? = nil, isPaidOut: Bool = false, date: Date = .now) {
        self.id = id
        self.betDescription = betDescription
        self.wagerAmount = wagerAmount
        self.bettors = bettors
        self.winner = winner
        self.isPaidOut = isPaidOut
        self.date = date
    }
}
