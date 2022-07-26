//
//  User.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/25/22.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var name: String
    var age: Int
    var company: String
    var about: String
    var registered: Date
    var tags: [String]
    var isActive: Bool
    var friends: [Friend]
}
