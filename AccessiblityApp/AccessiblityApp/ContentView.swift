//
//  ContentView.swift
//  AccessiblityApp
//
//  Created by Noah Glaser on 8/17/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var showPopup = false
    
    @State var value = 10
    
    var body: some View {
        VStack {
            Image("profile")
                .resizable()
                .scaledToFit()
                .accessibilityLabel("Noah's profile picture")
                .accessibilityAddTraits(.isButton)
                .onTapGesture {
                    showPopup = true
                }.alert("Hi", isPresented: $showPopup) {
                    Button("OK") {
                        
                    }
                }
            // means it does nto read label or image name
            Image(decorative: "profile")
                .resizable()
                .scaledToFit()
            // Does not read it all
                .accessibilityHidden(true)
            VStack {
                Text("Your Score is")
                Text("1000")
                    .font(.title)
                // Don't read the children
            }.accessibilityElement(children: .ignore)
                // Read this one all once
                .accessibilityLabel("Your score is 100")
            VStack {
                Text("Value: \(value)")
                Button("Increment") {
                    value += 1
                }
                Button("Decrement") {
                    value -= 1
                }
            }.accessibilityElement()
                .accessibilityLabel(String(value))
                .accessibilityAdjustableAction {
                    direction in
                    switch(direction) {
                    case .increment:
                        value += 1
                    case .decrement:
                        value -= 1
                    default:
                        print("Not handled")
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
