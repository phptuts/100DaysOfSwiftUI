//
//  EditView.swift
//  BucketList
//
//  Created by Noah Glaser on 8/13/22.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    enum LoadingState {
        case loading, loaded, failed
    }
        
    var onSave: (Location) -> Void
    
    
    @StateObject var viewModel: ViewModel
    
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        self._viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Near By") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }.navigationTitle("Place details")
                .toolbar {
                    Button("Save") {
                        onSave(viewModel.newLocation())
                        dismiss()
                    }
                }.task {
                    await viewModel.fetchNearByPlaces()
                }
        }
    }
    
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example, onSave: { l in } )
    }
}
