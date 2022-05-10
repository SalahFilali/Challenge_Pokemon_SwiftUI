//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import SwiftUI

@main
struct PokemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
