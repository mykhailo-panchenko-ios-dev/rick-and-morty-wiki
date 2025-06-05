//
//  AppState.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

struct AppState: ReduxState {
    
    var listState = ListState()
    var filterState = FilterState()
}
