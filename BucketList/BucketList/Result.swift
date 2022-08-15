//
//  Result.swift
//  BucketList
//
//  Created by Noah Glaser on 8/14/22.
//

import Foundation

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    static func <(lhs: Page, right: Page) -> Bool {
        lhs.title < right.title
    }
    
    var description: String {
        terms?["description"]?.first ?? "No Further informationlocation"
    }
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Result: Codable {
    let query: Query
}
