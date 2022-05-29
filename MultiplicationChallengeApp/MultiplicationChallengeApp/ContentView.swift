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
    
    @State private var questionLeft = 0
        
    @State private var answer: Int? = nil
    
    @State private var previousRightAnswer = 0
    
    @FocusState private var keyboardFocus: Bool
    
    @State private var otherMultiple = 1
    
    @State private var score = 0
    
    @State private var showGameOverAlert = false
    
    @State private var rotateDegree = 0.0
    
    @State private var showRightAnswer = false
    
    var rightAnswer: Int {
        otherMultiple * multiple
    }
    
    var userRight: Bool {
        rightAnswer == Int(answer ?? 0)
    }
    
    var numToWord: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.spellOut
        
        return formatter.string(from: multiple as NSNumber) ?? "Two"
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    Stepper("\(numToWord.localizedCapitalized) Times Table", value: $multiple, in: 2...12)
                    Stepper("Questions \(numQuestions) ", value: $numQuestions)
                    HStack {
                        Spacer()
                        Button("New Game") {
                            score = 0
                            questionLeft = numQuestions
                            otherMultiple = Int.random(in: 1...12)
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Score \(score)")
                        Spacer()
                    }
                    
                }
                
                
                Section("Quiz") {
                    HStack {
                        Spacer()
                        Text("\(multiple) x \(otherMultiple)")
                            .font(.largeTitle)
                            .padding()
                            .rotation3DEffect(.degrees(rotateDegree), axis: (x: 0.5, y: 1, z: 1))
                            .animation(.easeIn(duration: 0.5), value: rotateDegree)
                        Spacer()
                    }
                    TextField("", value: $answer, format: .number, prompt: Text("Answer"))
                        .keyboardType(.numberPad)
                        .focused($keyboardFocus)
                        .disabled(questionLeft <= 0)
                        
                    HStack {
                        Spacer()
                        Button("Submit") {
                            
                            questionLeft -= 1
                            previousRightAnswer = rightAnswer
                            if userRight {
                                score += 1
                                rotateDegree += 360.0
                                
                            } else {
                                score -= 1
                                showRightAnswer = true
                            }
                        
                            answer = nil
                            
                            
                            if questionLeft == 0 {
                                showGameOverAlert = true
                                return
                            }
                            
                            otherMultiple = Int.random(in: 1...12)
                            
                        }.disabled(questionLeft <= 0)
                        Spacer()
                    }
                }
                
            }.navigationTitle("Multiple Game")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            keyboardFocus = false
                        }
                        
                    }
                }
            
        }.alert("Game Over", isPresented: $showGameOverAlert) {
            Button("OK") {
                
            }
        } message: {
            Text("You score \(score)")
        }
        .alert("Wrong Answer", isPresented: $showRightAnswer) {
            Button("OK") {
            
            }
        } message: {
            Text("Right Answer \(previousRightAnswer)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
