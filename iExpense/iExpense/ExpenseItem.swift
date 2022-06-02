//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Noah Glaser on 5/31/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var name: String
    var type: String
    var amount: Double
    var id = UUID()
    
}
