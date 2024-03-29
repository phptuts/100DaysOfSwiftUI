//
//  ContentView.swift
//  WordScramble
//
//  Created by Noah Glaser on 5/17/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text(rootWord).font(.largeTitle).bold()
                List {
                    Section {
                        TextField("Enter your word", text: $newWord).autocapitalization(.none)
                        
                    }
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }.accessibilityElement()
                                .accessibilityLabel("\(word), \(word.count) letters")
                            
                        }
                    }
                }
            }.navigationTitle("Score: \(score)")
                .toolbar {
                    Button("New Game") {
                        startGame()
                    }
                }
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("Ok") {
                        
                    }
                } message: {
                    Text(errorMessage)
                }
        }
    }
    

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count >= 3 else {
            wordError(title: "Word too short", message: "Word must be greater than 3 letters")
            return
            
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used alreadly", message: "Be more originial")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word Not Possible", message: "You can't spell that word from \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not Recognized", message: "You can't just make it up")
            return
        }
        
        // Extra Validation
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += Int((usedWords.count + rootWord.count) / 2)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                usedWords.removeAll()
                return
            }
        }
        fatalError("Count not load start.txt from bundle");
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "end")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
