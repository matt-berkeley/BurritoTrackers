//
//  BettorDetailView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//


import SwiftUI
import SwiftData

struct BettorDetailView: View {
    var bettor: Bettor
    
    var body: some View {
        Form {
            Section(header: Text("Bettor Name")) {
                Text(bettor.name)
            }
            
            Section(header: Text("Wins Vs. Losses")) {
                BurritoBarChartView(wins: Double(bettor.wins), losses: Double(bettor.losses))
                    .frame(height: 200) // Adjust the height as needed
            }
            
            Section(header: Text("Win History")) {
                Text("Net Burritos earned: \(netBurritos(for: bettor))")
            }
            
            Section(header: Text("Bets")) {
                List(bettor.bets) { bet in
                    NavigationLink(destination: BetDetailView(bet: bet)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(bet.date.formatted(date: .numeric, time: .omitted))")
                                Text(bet.betDescription)
                                    .font(.body)
                                if bet.isPaidOut {
                                    Text("Paid")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                } else if !bet.isCompleted {
                                    Text("In Progress")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                            Spacer()
                            if let winner = bet.winner {
                                if winner.id == bettor.id {
                                    Text("W")
                                        .foregroundColor(.green)
                                        .fontWeight(.bold)
                                } else {
                                    Text("L")
                                        .foregroundColor(.red)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Bettor Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func netBurritos(for bettor: Bettor) -> Int {
        var netBurritos = 0
        for bet in bettor.bets {
            if bet.isCompleted {
                if let winner = bet.winner, winner.id == bettor.id {
                    netBurritos += bet.wagerAmount
                } else {
                    netBurritos -= bet.wagerAmount
                }
            }
        }
        return netBurritos
    }
    
}


//#Preview {
//    BettorDetailView(bettor: sampleBett
//



//
//#Preview {
//    BettorDetailView(bettor: nil) // Provide a sample bettor for preview
//}



//
//#Preview {
//    BettorDetailView(bettor: nil) // Provide a sample bettor for preview
//}
