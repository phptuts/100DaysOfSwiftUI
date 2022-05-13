//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Noah Glaser on 5/13/22.
//

import SwiftUI

enum Move: String, Comparable, CaseIterable {
    static func < (lhs: Move, rhs: Move) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    
    case rock
    case paper
    case scissors
}

enum PlayerChoice: Comparable, CaseIterable {
    case winner, loser
}



extension Image {
    func resize() -> some View {
       return self
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

struct ContentView: View {
    
    @State var questionAnswered = 0
    
    @State var winningPicks: [(
        move: PlayerChoice,
        player: Move,
        computer: Move
    )] = [
        (.winner, .paper, .rock),
        (.winner, .scissors, .paper),
        (.winner, .rock, .scissors),
        (.loser, .scissors, .rock),
        (.loser, .rock, .paper),
        (.loser, .paper, .scissors)
    ]
    
    @State var computerMove = Move.allCases.randomElement() ?? Move.scissors
    
    @State var movePicked = PlayerChoice.allCases.randomElement() ?? PlayerChoice.winner
    
    @State var score = 0
    
    @State var previousWinningMove: Move?
    
    @State var showFinalScore = false
    
    @State var showWrongAnswer = false
    
    func nextMove(_ playerMove: Move) {
        
        guard let winningPick = winningPicks.first(where: { $0.move == movePicked && $0.computer == computerMove }) else {
            return
        }
        
        previousWinningMove = winningPick.player
        if playerMove == winningPick.player {
            score += 1
        } else {
            score -= 1
            showWrongAnswer = true
        }
    
        
        questionAnswered += 1
        computerMove = Move.allCases.randomElement() ?? Move.scissors
        movePicked = PlayerChoice.allCases.randomElement() ?? PlayerChoice.winner
        
        if questionAnswered == 10 {
            showFinalScore = true
        }
        
    }
    
    var body: some View {
        VStack {
            Text(movePicked == .winner ? "Pick Winner" : "Pick Loser")
                .font(.largeTitle)
                .bold()
            Text("Score: \(score)")
                .font(.largeTitle)
                .bold()
            Spacer()
            Image(computerMove.rawValue)
                .resize()
                .padding(75)
            Spacer()
            Spacer()
            HStack {
                Button {
                    nextMove(.rock)
                } label: {
                    Image(Move.rock.rawValue)
                        .resize()
                        .padding(20)
                }
                Button {
                    nextMove(.paper)
                } label: {
                    Image(Move.paper.rawValue)
                        .resize()
                        .padding(20)
                }
                Button {
                    nextMove(.scissors)
                } label: {
                    Image(Move.scissors.rawValue)
                        .resize()
                        .padding(20)
                }
            }
        }.alert("Final Score", isPresented: $showFinalScore, actions: {
            Button("Play Again") {
                questionAnswered = 0
                score = 0
            }
        }, message: {
           Text("You scored: \(score)")
        }).alert("Wrong Answer", isPresented: $showWrongAnswer, actions: {
            Button("Continue") {
                
            }
        }, message: {
            Text("The correct answer is \(previousWinningMove?.rawValue ?? "Unknown").")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
