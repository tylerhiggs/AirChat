//
//  AirchatApp.swift
//  Airchat
//
//  Created by Tyler Higgs on 11/21/22.
//

import SwiftUI

@main
struct AirchatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
