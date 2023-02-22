//
//  MC3appApp.swift
//  MC3app
//
//  Created by Giuseppe Rocco on 20/02/23.
//

import SwiftUI

@main
struct MC3appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainPage()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
