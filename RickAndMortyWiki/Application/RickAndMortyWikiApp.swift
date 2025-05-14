//
//  RickAndMortyWikiApp.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

import SwiftUI
import SwiftData

typealias AppStore = Store<AppState, RootReducer>

@main
struct RickAndMortyWikiApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
