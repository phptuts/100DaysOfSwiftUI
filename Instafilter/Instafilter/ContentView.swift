//
//  ContentView.swift
//  Instafilter
//
//  Created by Noah Glaser on 8/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var blurAmount = 0.0
    
    @State private var showingConfirmation = false
    
    @State private var backgroundColor = Color.white
    
    var body: some View {
//        VStack {
//            Text("Hello world")
//                .blur(radius: blurAmount)
//            Slider(value: $blurAmount, in: 0...20)
//                .onChange(of: blurAmount) {
//                    newValue in
//                    print("New blur amount \(newValue)")
//                }
//            Button("Random Blur") {
//                blurAmount = Double.random(in: 0...20)
//            }
//        }
        Text("Hello, World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }
            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Select a new color")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
