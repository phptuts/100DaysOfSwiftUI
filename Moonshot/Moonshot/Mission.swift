//
//  Mission.swift
//  Moonshot
//
//  Created by Noah Glaser on 6/8/22.
//

import Foundation



struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    var id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    func createCrewMembers(astronauts: [String: Astronaut]) -> [CrewMember] {
        return self.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
}
