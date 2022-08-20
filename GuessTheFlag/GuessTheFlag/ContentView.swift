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
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var selectedAnswer = 0
    @State private var questionNumber = 1;
    @State private var showEndGameAlert = false
    
    @State private var flaggedClicked = 0
    @State private var flagRotations = [0.0, 0.0, 0.0]
    @State private var flagOpacity = [1.0, 1.0, 1.0]
    @State private var flagScale = [1.0, 1.0, 1.0]
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
                            flagRotations[number] += 360

                            for i in 0..<flagScale.count {
                                flagOpacity[i] = number == i ? 1 : 0.25;
                                flagScale[i] = number == i ? 1 : 0.75;
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                flagScale = [1.0, 1.0, 1.0]
                                flagOpacity = [1.0, 1.0, 1.0]
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    flagTapped(number)
                                }
                            }
                            
                        } label: {
                            FlagImage(flagImage: countries[number])
                                .accessibilityLabel(labels[countries[number], default: "Unknown Flag"])
                                .rotation3DEffect(.degrees(flagRotations[number]), axis: (x: 0, y: 1, z: 0))
                                .animation(.easeInOut(duration: 0.5), value: flagRotations[number])
                                .scaleEffect(flagScale[number])
                                .animation(.easeInOut(duration: 0.5), value: flagScale[number])
                                .opacity(flagOpacity[number])
                                .animation(.easeInOut(duration: 0.5), value: flagOpacity[number])
                                
                        }
                        
//                        Button {
//                            withAnimation(.easeIn(duration: 0.5)) {
//                                flagRotations[number] += 360
//
//                                for i in 0..<flagScale.count {
//                                    flagOpacity[i] = number == i ? 1 : 0.25;
//                                    flagScale[i] = number == i ? 1 : 0.75;
//                                }
//                            }
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                                withAnimation(.easeOut(duration: 0.5)) {
//                                    flagOpacity = [1.0, 1.0, 1.0]
//                                    flagScale = [1.0, 1.0, 1.0]
//                                }
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                                    flagTapped(number)
//                                })
//                            })
//                        } label: {
//                            FlagImage(flagImage: countries[number])
//                                .rotation3DEffect(.degrees(flagRotations[number]), axis: (x: 0, y: 1, z: 0))
//                                .scaleEffect(flagScale[number])
//                                .opacity(flagOpacity[number])
//
//                        }
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
        flaggedClicked = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
