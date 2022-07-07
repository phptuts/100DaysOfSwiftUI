//
//  Order.swift
//  CupcakeCorner
//
//  Created by Noah Glaser on 7/4/22.
//

import SwiftUI

class OrderStore: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocalate", "Rainbow"]
    
    init() {
        order = Order()
    }
    
    @Published var order: Order


}

struct Order: Codable {
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !zip.isEmpty
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost = Double(quantity) / 2
        }
        
        return cost
    }
}
