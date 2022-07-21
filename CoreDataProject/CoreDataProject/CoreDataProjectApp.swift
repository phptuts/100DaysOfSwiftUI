//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Noah Glaser on 7/17/22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @State private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
           ContentView()
               .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
