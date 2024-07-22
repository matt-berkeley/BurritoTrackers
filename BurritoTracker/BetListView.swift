//
//  BetListView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//

import SwiftUI
import SwiftData

struct BetListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Bet.date) private var bets: [Bet]
    
    @State private var searchText: String = ""
    
    // Filtered bets based on search text
    private var filteredBets: [Bet] {
        let searchTextLowercased = searchText.lowercased()
        
        if searchText.isEmpty {
            return bets
        } else {
            return bets.filter { bet in
                // Check if the bet description contains the search text
                let descriptionMatch = bet.betDescription.lowercased().contains(searchTextLowercased)
                
                // Check if any bettor's name contains the search text
                let bettorMatch = bet.bettors.contains { bettor in
                    bettor.name.lowercased().contains(searchTextLowercased)
                }
                
                return descriptionMatch || bettorMatch
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredBets) { bet in
                NavigationLink(destination: BetDetailView(bet: bet)) {
                    VStack(alignment: .leading) {
                        HStack {
                            ForEach(bet.bettors) { bettor in
                                HStack {
                                    
                                    Text(bettor.name)
                                        .font(.headline)
                                }
                                if bettor != bet.bettors.last {
                                    Text("vs.")
                                }
                                
                            }
                            Spacer()
                            Text(bet.date.formatted(date: .numeric, time: .omitted))

                        }
                        Text(bet.betDescription)
                            .font(.headline)
                        
                        Text("^[\(bet.wagerAmount) burrito](inflection: true)")
                    }
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(bet)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search by name or description")
            .navigationTitle("Bets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddBetView()) {
                        Image(systemName: "plus")
                            .imageScale(.large) // Use default SF Symbols size
                    }
                }
            }
        }
    }
}

#Preview {
    BetListView()
}
