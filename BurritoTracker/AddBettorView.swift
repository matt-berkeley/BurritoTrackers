//
//  AddBettorView.swift
//  BurritoTracker
//
//  Created by Matt Ginelli on 7/20/24.
//

import SwiftUI
import SwiftData

struct AddBettorView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss // To dismiss the sheet
    @State private var bettorName: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Enter Bettor's Name")) {
                    TextField("Name", text: $bettorName)
                }
                
                Button("Add Bettor") {
                    addBettor()
                }
                .disabled(bettorName.isEmpty) // Disable if name is empty
            }
            .padding()
        }
        .presentationDetents([.medium]) // Present as half-sheet
        .onSubmit {
            addBettor()
        }
    }
    
    private func addBettor() {
        guard !bettorName.isEmpty else { return }
        modelContext.insert(Bettor(name: bettorName))
        bettorName = ""
        dismiss() // Dismiss the sheet
    }
}

#Preview {
    AddBettorView()
}
