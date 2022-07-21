//
//  FilterListChallengeApp.swift
//  FilterListChallenge
//
//  Created by Noah Glaser on 7/20/22.
//

import SwiftUI

@main
struct FilterListChallengeApp: App {
    @State private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
