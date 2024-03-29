//
//  ContentView.swift
//  Flashzilla
//
//  Created by Noah Glaser on 9/21/22.
//

import SwiftUI
import CoreHaptics

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    
   
    @State var cards = [Card]()
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .padding(.vertical, 5)
                ZStack {
                    ForEach(cards, id: \.id) { card in
                        let index = cards.firstIndex(where: { $0.id == card.id }) ?? 0
                        
                        CardView(card: card) {
                            removeCard(card: card)
                        } sendToBack: {
                    
                            var tempCards = cards.filter { $0.id != card.id}
                            tempCards.insert(Card(prompt: card.prompt, answer: card.answer), at: 0)
                            cards = tempCards
                            print(cards)
                            
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsTightening(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                   
                }
                Spacer()
            }.foregroundColor(.white)
                .font(.largeTitle)
                .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(card: cards.last ?? Card.example)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityLabel("Mark your answer as being incorrect")
                        
                        Spacer()
                        Button {
                            removeCard(card: cards.last ?? Card.example)
                        } label : {
                            Image(systemName: "checkmark.circle")
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityLabel("Mark your answer as being correct")
                    }.foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                }
            }
        }
        .sheet(isPresented: $showingEditScreen) {
            EditCards()
        }
        .onReceive(timer) { time in
            if timeRemaining > 0 && isActive {
                timeRemaining -= 1
            }
        }
        .onChange(of: cards) {
            print("CARDS", $0)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active && cards.isEmpty {
                cards = Card.getCards()
            }
            
            if newPhase == .active && !cards.isEmpty {
                isActive = true
            } else {
                isActive = false
            }
        }
        .onChange(of: showingEditScreen) { show in
            resetCards()
        }
        
    }
    
    func removeCard(card: Card) {
        
        cards = cards.filter { $0.id != card.id }
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        cards = Card.getCards()
        timeRemaining = 100
        isActive = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
