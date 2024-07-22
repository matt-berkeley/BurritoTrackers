//
//  BurritoTrackerApp.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//

import SwiftUI
import SwiftData

@main
struct BurritoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Bet.self, Bettor.self])
    }
}
