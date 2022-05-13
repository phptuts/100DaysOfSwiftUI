//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Noah Glaser on 5/7/22.
//

import SwiftUI

struct FlagImage: View {
    
    let flagImage: String
    
    var body: some View {
        Image(flagImage)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct BlueLargeText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45 ))
    }
}

extension View {
    func largeBlueText() -> some View {
        modifier(BlueLargeText())
    }
}

struct ContentView: View {

    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var selectedAnswer = 0
    @State private var questionNumber = 1;
    @State private var showEndGameAlert = false
    
    @State private var score = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45 ), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius:   700).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flagImage: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)").largeBlueText()
                Spacer()
            }.padding()

        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct" {
                Text("Your score is \(score)")
            } else {
                Text("Wrong! That's the flag of \(countries[selectedAnswer])")
            }
            
        }.alert("Game Over", isPresented: $showEndGameAlert) {
            Button("Continue") {
                questionNumber = 0
                score = 0
            }
        } message: {
            Text("You're total score was \(score)")
        }
        
    }
    
    func flagTapped(_ number: Int) {
        selectedAnswer = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        
        if (questionNumber < 8) {
            questionNumber += 1;
        } else {
           showEndGameAlert = true
        }
        
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
