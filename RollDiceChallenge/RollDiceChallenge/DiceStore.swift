//
//  DiceStore.swift
//  RollDiceChallenge
//
//  Created by Noah Glaser on 10/19/22.
//

import Foundation


@MainActor class DiceStore: ObservableObject {
    @Published  var rolls = [Int]()
    
    init() {
        do {
            rolls = try FileManager.read(fileName: "rolls")
        } catch {
            
        }
    }
    
    func addRole(role: Int) throws {
        rolls.insert(role, at: 0)
        try save()
    }
    
    func deleteRolls() throws {
        rolls.removeAll()
        try save();
        print("Saved Rolls")
    }
    
    func save() throws {
        try FileManager.write(objects: rolls, fileName: "rolls")
    }
    
    
}
