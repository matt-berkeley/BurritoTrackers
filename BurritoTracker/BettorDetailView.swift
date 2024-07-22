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
            Section(header: Text("Bets")) {
                List(bettor.bets) { bet in
                    NavigationLink(destination: BetDetailView(bet: bet)) {
                        HStack {
                            Text("\(bet.date.formatted(date: .numeric, time: .omitted))")
                            Text(bet.betDescription)
                                .font(.body)
                        }
                    }
                }
            }
        }
        .navigationTitle("Bettor Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}



//
//#Preview {
//    BettorDetailView(bettor: nil) // Provide a sample bettor for preview
//}



//
//#Preview {
//    BettorDetailView(bettor: nil) // Provide a sample bettor for preview
//}
