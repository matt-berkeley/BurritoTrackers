import SwiftUI
import SwiftData

struct AddBetView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Bettor.name) var bettors: [Bettor]
    
    @State private var selectedBettor1: Bettor?
    @State private var selectedBettor2: Bettor?
    @State private var betDescription: String = ""
    @State private var wagerAmount: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Bet Details")) {
                    TextEditor(text: $betDescription)
                        .frame(height: 100)
                    TextField("Wager Amount", text: $wagerAmount)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Select Bettors")) {
                    Picker("Bettor", selection: $selectedBettor1) {
                        Text("Select Name").tag(Bettor?.none)
                        ForEach(bettors) { bettor in
                            Text(bettor.name).tag(bettor as Bettor?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Bettor 2", selection: $selectedBettor2) {
                        Text("Select Name").tag(Bettor?.none)
                        ForEach(bettors) { bettor in
                            Text(bettor.name).tag(bettor as Bettor?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Button("Add Bet") {
                    addBet()
                }
                .disabled(betDescription.isEmpty || wagerAmount.isEmpty || selectedBettor1 == nil || selectedBettor2 == nil || selectedBettor1 == selectedBettor2)
            }
        }
        .padding()
    }
    
    private func addBet() {
        guard let wager = Int(wagerAmount), let bettor1 = selectedBettor1, let bettor2 = selectedBettor2 else {
            print("Error: Invalid input or selection.")
            return
        }
        
        // Ensure bettors are different
        guard bettor1.id != bettor2.id else {
            print("Error: Bettors cannot be the same.")
            return
        }
        
        let bet = Bet(betDescription: betDescription, wagerAmount: wager, bettors: [bettor1, bettor2])
        
        modelContext.insert(bet)
        
        // Append bet to bettors
        bettor1.bets.append(bet)
        bettor2.bets.append(bet)
        
        do {
            try modelContext.save()
            print("Successfully saved the bet.")
        } catch {
            print("Failed to save bet: \(error)")
        }
        
        // Clear form
        betDescription = ""
        wagerAmount = ""
        selectedBettor1 = nil
        selectedBettor2 = nil
        
        dismiss()
        // dismiss the add bet sheet
        
    }
}

#Preview {
    AddBetView()
}
