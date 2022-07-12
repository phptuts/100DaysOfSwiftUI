//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Noah Glaser on 7/8/22.
//

import SwiftUI

@main
struct BookWormApp: App {
    
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
