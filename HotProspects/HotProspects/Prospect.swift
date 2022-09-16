//
//  Prospect.swift
//  HotProspects
//
//  Created by Noah Glaser on 9/15/22.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
    
}


@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = [Prospect]()
    }
}
