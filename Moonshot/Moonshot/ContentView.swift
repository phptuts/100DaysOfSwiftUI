//
//  ContentView.swift
//  Moonshot
//
//  Created by Noah Glaser on 6/4/22.
//

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    
    @State var isGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                    if (isGrid) {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                MissionListView(missions: missions, astronauts: astronauts)
                            }.padding([.horizontal, .vertical])
                        }
                    } else {
                        List {
                            MissionListView(missions: missions, astronauts: astronauts)
                        }
                    }
            }
            .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar {
                    ToolbarItem {
                        Button("\(isGrid ? "List" : "Grid")") {
                            isGrid.toggle()
                        }
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
