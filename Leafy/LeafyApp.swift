//
//  Copyright (c) 2025 Giuseppe Rocco
//  Copyright (c) 2025 Aryan Garg
//  Licensed under the MIT License. See the LICENSE file for details.
//
//  -----------------------------------------------------------------
//
//  LeafyApp.swift
//  Leafy
//
//  Created by Giuseppe Rocco on 20/02/23.
//

import SwiftUI

@main
struct LeafyApp: App {
    let persistenceController = PersistenceController.shared // Container to save the study cards
    
    var body: some Scene {
        WindowGroup {
            MainPage()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
