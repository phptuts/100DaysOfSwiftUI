//
//  Prospect.swift
//  HotProspects
//
//  Created by Noah Glaser on 9/15/22.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var created = Date()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
}

enum TestError: Error {
    case test
}

enum Sort {
    case name, date
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let fileName = "people.json"
    
    
    
    
    init() {
        do {
            people = try FileManager.read(fileName: fileName)
        } catch {
            people = []
        }
    }
    
    private func save() throws {
       try FileManager.write(objects: people, fileName: fileName)
    }
    
    func toggle(_ prospect: Prospect) throws {
        objectWillChange.send()
        prospect.isContacted.toggle()
        try save()
        // For testing purposes
        if people.count == 5 {
            throw TestError.test
        }
    }
    
    func add(_ prospect: Prospect) throws {
        people.append(prospect)
        try save()
        
    }
}
