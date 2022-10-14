//
//  EditCards.swift
//  Flashzilla
//
//  Created by Noah Glaser on 10/12/22.
//

import SwiftUI

struct EditCards: View {
    
    @State var cards = [Card]()
    @State var prompt = ""
    @State var answer = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Return Home") {
                    dismiss()
                }
                HStack {
                    Form {
                        TextField("Prompt",  text: $prompt)
                        TextField("Answer", text: $answer)
                        Button("Add Card", action: addCard)
                    }
                    Spacer()
                    List {
                        ForEach(cards, id: \.id) { card in
                            VStack(alignment: .leading) {
                                Text(card.prompt)
                                    .font(.headline)
                                Spacer()
                                Text(card.answer)
                                    .font(.callout)
                                    
                            }
                            .padding()
                        }.onDelete { offset in
                            cards.remove(atOffsets: offset)
                            Card.saveCards(cards: cards)
                        }
                    }
                    
                }
            }
            .navigationTitle("Edit View")
                .onAppear {
                    cards = Card.getCards()
                }
        }
    }
    
    func addCard() {
        cards.append(Card(prompt: prompt, answer: answer))
        Card.saveCards(cards: cards)
        prompt = ""
        answer = ""
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
