//
//  Resort.swift
//  SnowSeeker
//
//  Created by Noah Glaser on 10/21/22.
//

import Foundation


struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example =  allResorts[0]
}
