//
//  ContentView.swift
//  RollDiceChallenge
//
//  Created by Noah Glaser on 10/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sides = 30
    
    @State private var errorMessage = ""
    
    @State private var lastRoll = 0
    
    @State private var rolling = false
    
    @StateObject private var diceStore = DiceStore()
    
    let maxDiceFlips = 20
    
    let minDiceFlips = 3
    
    @State private var rollCount = 0
    
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
                Form {
                    Stepper("\(sides) Sides", value: $sides)
                    HStack {
                        Spacer()
                        Button("Roll them dice", action: startRoll)
                        Spacer()
                    }
                    
                    Section("Dice") {
                        Text("\(lastRoll)")
                            .font(.largeTitle)
                    }
                    HStack {
                        Spacer()
                        Button("Delete Previous Rolls", role:.destructive,  action: deletePreviousRolls)
                        Spacer()
                    }
                    Section("Previous Rolls") {
                        List(0..<diceStore.rolls.count, id: \.self) { rollTimes in
                            Text("Rolled \(diceStore.rolls[rollTimes] )")
                        }
                    }
                    
                    
                }
                .onReceive(timer, perform:  { _ in rollignDice() })
                .onAppear {
                    lastRoll = diceStore.rolls.first ?? 0
                }
            .navigationTitle("Role Them Dice")
        }
        
    }
    
    func startRoll() {
        rollCount = Int.random(in: minDiceFlips...maxDiceFlips)
        randomFlip()
        rollCount -= 1
        rolling = true
    }
    
    func randomFlip() {
        let roll = Int.random(in: 1...sides)
        lastRoll = roll
    }
    
    func rollignDice() {
        if rolling && rollCount > 1 {
            randomFlip()
            rollCount -= 1
        } else if rollCount == 1 {
            rolling = false
            rollCount = 0
            finalRoll()
        }
    }
    
   func deletePreviousRolls() {
       DispatchQueue.main.async {
           do {
               try diceStore.deleteRolls()
           } catch {
               print(error.localizedDescription)
           }
       }
    }
    
    func finalRoll() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        randomFlip()
        do {
           try diceStore.addRole(role: lastRoll)
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
