//
//  EditView+ViewModel.swift
//  BucketList
//
//  Created by Noah Glaser on 8/16/22.
//

import Foundation


extension EditView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name: String = ""
        @Published var description: String = ""
        @Published private(set) var loadingState = LoadingState.loading
        @Published private(set) var pages = [Page]()
        
        @Published var location: Location
        
        init (location: Location) {
            self.name = location.name
            self.description = location.description
            self.location = location
        }
        
        func setLocation(location: Location) {
            self.name = location.name
            self.description = location.description
            self.location = location
        }
        
        func newLocation() -> Location {
            var loc = location
            loc.name = name
            loc.description = description
            loc.id = UUID()
            
            return loc
        }
        
        func fetchNearByPlaces() async  {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}
