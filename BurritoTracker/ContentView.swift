//
//  ContentView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView {
            
            BettorListView()
                .tabItem {
                    Label("Bettors", systemImage: "person.3.sequence.fill")
                }
                .tag(0)
            
            BetListView()
                .tabItem {
                    Label("Bet List", systemImage: "list.bullet")
                }
                .tag(1)
            
        }
    }
}

#Preview {
    ContentView()
}
