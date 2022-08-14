//
//  EditView.swift
//  BucketList
//
//  Created by Noah Glaser on 8/13/22.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var location: Location
    
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self._name = State(initialValue: location.name)
        self._description = State(initialValue: location.description)
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }.navigationTitle("Place details")
                .toolbar {
                    Button("Save") {
                        
                        var newLocation = location
                        newLocation.name = name
                        newLocation.description = description
                        newLocation.id = UUID()
                        onSave(newLocation)
                        dismiss()
                    }
                }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example, onSave: { l in } )
    }
}
