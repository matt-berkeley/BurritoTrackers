//
//  BetDetailView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//

import SwiftUI
import SwiftData

struct BetDetailView: View {
    var bet: Bet
    
    @State private var selectedWinner: Bettor?
    
    var body: some View {
        Form {
            Section(header: Text("Bet Description")) {
                Text(bet.betDescription)
                    .font(.body)
            }
            
            Section(header: Text("Wager Amount")) {
                Text("^[\(bet.wagerAmount) burrito](inflection: true)")
                    .font(.body)
            }
            
            Section(header: Text("Bettors")) {
                ForEach(bet.bettors) { bettor in
                    NavigationLink(destination: BettorDetailView(bettor: bettor)) {
                        Text(bettor.name)
                    }
                }
            }
            
            if bet.winner == nil {
                Section(header: Text("Select Winner")) {
                    Picker("Winner", selection: $selectedWinner) {
                        Text("Select Winner").tag(Bettor?.none)
                        ForEach(bet.bettors) { bettor in
                            Text(bettor.name).tag(bettor as Bettor?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    if let winner = selectedWinner {
                        Button("Set Winner") {
                            setWinner(winner)
                        }
                    }
                }
            } else {
                Section(header: Text("Winner")) {
                    Text(bet.winner?.name ?? "No winner selected")
                }
            }
        }
        .navigationTitle("Bet Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func setWinner(_ winner: Bettor) {
        bet.winner = winner
    }
    
}

