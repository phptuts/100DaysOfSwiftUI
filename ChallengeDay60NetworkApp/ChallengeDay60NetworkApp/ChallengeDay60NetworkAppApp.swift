//
//  ChallengeDay60NetworkAppApp.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/25/22.
//

import SwiftUI

@main
struct ChallengeDay60NetworkAppApp: App {
    @State private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
