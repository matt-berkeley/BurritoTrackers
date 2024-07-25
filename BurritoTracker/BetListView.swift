import SwiftUI
import SwiftData

enum BetFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case active = "Undecided"
    case unpaid = "Unpaid"
    
    var id: String { self.rawValue }
}

struct BetListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Bet.date, order: .reverse) private var bets: [Bet]
    
    @State private var searchText: String = ""
    @State private var selectedFilter: BetFilter = .all
    
    // Filtered bets based on search text and selected filter
    private var filteredBets: [Bet] {
        let searchTextLowercased = searchText.lowercased()
        let filteredBySearchText = searchText.isEmpty ? bets : bets.filter { bet in
            let descriptionMatch = bet.betDescription.lowercased().contains(searchTextLowercased)
            let bettorMatch = bet.bettors.contains { bettor in
                bettor.name.lowercased().contains(searchTextLowercased)
            }
            return descriptionMatch || bettorMatch
        }
        
        switch selectedFilter {
        case .all:
            return filteredBySearchText
        case .active:
            return filteredBySearchText.filter { $0.winner == nil }
        case .unpaid:
            return filteredBySearchText.filter { $0.winner != nil && !$0.isPaidOut }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(BetFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .padding([.horizontal, .top])
                .pickerStyle(SegmentedPickerStyle())
                List(filteredBets) { bet in
                    NavigationLink(destination: BetDetailView(bet: bet)) {
                        HStack {
                            if bet.isPaidOut {
                                PaidStampView()
                            }
                            Spacer() 
                            VStack(alignment: .leading) {
                                HStack {
                                    ForEach(bet.bettors) { bettor in
                                        HStack {
                                            Text(bettor.name)
                                                .foregroundStyle(bet.winner?.id == bettor.id ? .green : .primary)
                                                .font(.headline)
                                        }
                                        if bettor != bet.bettors.last {
                                            Text("vs.")
                                        }
                                    }
                                    Spacer()
                                    Text(bet.date.formatted(date: .numeric, time: .omitted))
                                        .font(.caption)
                                }
                                Text(bet.betDescription)
                                    .font(.headline)
                                
                                Text("^[\(bet.wagerAmount) burrito](inflection: true)")
                                
                                HStack {
                                    if bet.winner == nil {
                                        Text("Undecided Winner")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    } else if !bet.isPaidOut {
                                        Text("Unpaid")
                                            .font(.caption)
                                            .foregroundStyle(.red)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(bet)
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search by name or description")
            }
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
