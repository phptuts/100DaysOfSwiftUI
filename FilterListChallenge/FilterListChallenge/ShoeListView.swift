//
//  ShoeListView.swift
//  FilterListChallenge
//
//  Created by Noah Glaser on 7/20/22.
//

import SwiftUI

enum BrandPredicate {
    case beginsWith(name: String)
    case contains(name: String)
}

struct ShoeListView: View {
    
    
    @FetchRequest(sortDescriptors: []) var shoes: FetchedResults<Shoe>
    var brandFilter: BrandPredicate
    
    
    init (brandFilter: BrandPredicate, sortBy: [SortDescriptor<Shoe>]) {
        self.brandFilter = brandFilter
        let (predicateString, brand) = getBrand()
        _shoes = FetchRequest(sortDescriptors: sortBy, predicate: NSPredicate(format: predicateString, brand))
    }
    
    
    func getBrand() -> (String, String) {
        
        switch self.brandFilter {
        case .beginsWith(name: let name):
            return ("brand beginsWith %@", name)
    
        case .contains(name: let name):
            return ("brand contains %@", name)
        }
    }
    
    var body: some View {
        List {
            ForEach(shoes, id:\.self) { shoe in
                HStack {
                    Text(shoe.name ?? "Unknown Name")
                    Spacer()
                    Text(shoe.brand ?? "Unknown Brand")
                }
            }
        }.onAppear {
            print(brandFilter)
        }
    }
}


