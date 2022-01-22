//
//  todoApp.swift
//  todo
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import SwiftUI

@main
struct BlueHourApp: App {
    let config = Config()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(config)
        }
    }
}
