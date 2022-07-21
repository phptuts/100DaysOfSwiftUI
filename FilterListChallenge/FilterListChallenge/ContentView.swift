//
//  ContentView.swift
//  FilterListChallenge
//
//  Created by Noah Glaser on 7/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var brand = "Nike"
    
    let brands: [String] = ["Nike", "New Balance", "Sketchers", "N", "S", "Shoe"]
    @State var filter = BrandPredicate.beginsWith(name: "Nike")
    var body: some View {
        VStack {
            ShoeListView(brandFilter: filter, sortBy: [SortDescriptor(\.name, order: .reverse)])
            Picker("Brand", selection: $brand) {
                ForEach(brands, id: \.self) {
                    Text($0)
                }
            }.onChange(of: brand, perform: {
                brand in
                switch(filter) {
                case .contains:
                    filter = .contains(name: brand)
                case .beginsWith:
                    filter = .beginsWith(name: brand)
                }
            })
            Button("Begins With") {
                filter = .beginsWith(name: brand)
            }
            Button("Contains") {
                filter = .contains(name: brand)
            }
            Button("Add Examples") {
                let shoe1 = Shoe(context: moc)
                shoe1.brand = "Fun Shoes"
                shoe1.name = "Shoe Ers"
                
//                let shoe2 = Shoe(context: moc)
//                shoe2.brand = "Nike"
//                shoe2.name = "Air Jordan"
//
//                let shoe3 = Shoe(context: moc)
//                shoe3.brand = "New Balance"
//                shoe3.name = "N30s"
//
//                let shoe4 = Shoe(context: moc)
//                shoe4.brand = "Sketchers"
//                shoe4.name = "Washable"
                
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
