//
//  RootReducer.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//


struct RootReducer: ReduxReducer {
    
func reduce(state: AppState?, action: ReduxAction?) -> AppState {
       return state ?? AppState()
    }
    
}
