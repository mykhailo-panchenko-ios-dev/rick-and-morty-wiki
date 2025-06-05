//
//  RickAndMortyWikiApp.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

import SwiftUI
import SwiftData
import Combine

typealias AppStore = Store<AppState, RootReducer>

@main
struct RickAndMortyWikiApp: App {
    
    private var store: AppStore = {
        let networkLayer = NetworkLayer()
        let serviceBuilder = ServiceFactory(networkLayer: networkLayer)
        return Store(
            initialState: AppState(listState: ListState(),
                                   filterState: FilterState()),
            rootReducer: RootReducer(filterReducer: FilterReducer()),
            middlewares: [FilterMiddleware(filterCharacterService: serviceBuilder.makeFilterService())])
    }()
       
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
            FilterView().environmentObject(store)
        }
        .modelContainer(sharedModelContainer)
    }
}
