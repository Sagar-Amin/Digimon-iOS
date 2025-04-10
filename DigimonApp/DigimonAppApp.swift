//
//  DigimonAppApp.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

import SwiftUI

@main
struct DigimonAppApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
