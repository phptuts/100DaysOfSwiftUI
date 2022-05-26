//
//  ContentView.swift
//  MultiplicationChallengeApp
//
//  Created by Noah Glaser on 5/25/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var multiple = 3
    
    @State private var numQuestions = 5
    
    @State private var playing = false
    
    var numToWord: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.spellOut

        return formatter.string(from: multiple as NSNumber) ?? "Two"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !playing {
                    Form {
                        Section {
                            Stepper("\(numToWord.localizedCapitalized) Times Table", value: $multiple, in: 2...12)
                            Stepper("Questions \(numQuestions) ", value: $numQuestions)
                            HStack {
                                Spacer()
                                Button("Start Game") {
                                    playing = true
                                }
                                Spacer()
                            }
                            
                            
                        }
                    }
                }
                
                
                
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
