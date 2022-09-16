//
//  ContentView.swift
//  HotProspects
//
//  Created by Noah Glaser on 8/27/22.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var prospects = Prospects()
        
    var body: some View {
        TabView {
            ProspectView(filter: .none)
                .tabItem {
                    Label("EveryOne", systemImage: "person.3")
                }
            ProspectView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }.environmentObject(prospects)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
