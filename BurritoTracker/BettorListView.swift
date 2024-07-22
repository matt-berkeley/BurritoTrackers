//
//  BettorListView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//

import SwiftUI
import SwiftData

struct BettorListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Bettor.name) private var bettors: [Bettor]
    
    @State private var searchText: String = ""

    // Filtered and sorted bettors based on search text
    private var filteredBettors: [Bettor] {
        let sortedBettors = bettors.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        
        if searchText.isEmpty {
            return sortedBettors
        } else {
            return sortedBettors.filter { bettor in
                bettor.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredBettors) { bettor in
                NavigationLink(destination: BettorDetailView(bettor: bettor)) {
                    VStack(alignment: .leading) {
                            Text(bettor.name)
                            Text("\(bettor.wins) - \(bettor.losses)")
                    }
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(bettor)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search by name")
            .navigationTitle("Bettors")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddBettorView()) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    BetListView()
}
