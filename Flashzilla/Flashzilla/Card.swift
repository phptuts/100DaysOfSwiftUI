//
//  Card.swift
//  Flashzilla
//
//  Created by Noah Glaser on 9/27/22.
//

import Foundation

struct Card: Codable, Equatable {
    var prompt: String
    var answer: String
    var id = UUID()
 
    static func getCards() -> [Card] {
        guard let cardString = UserDefaults.standard.data(forKey: "cards") else {
            return []
        }
        
        let decoder = JSONDecoder()
        let cards = try? decoder.decode([Card].self, from: cardString)
        
        return cards ?? []
    }
    
    static func saveCards(cards: [Card]) {
        let encoder = JSONEncoder()
        if let cardData = try? encoder.encode(cards) {
            UserDefaults.standard.set(cardData, forKey: "cards")

        }
        
    }
    
    static let example = Card(prompt: "Who played the 13th Doctor in the Doctor Who?", answer: "Jodie Whittaker")
}
