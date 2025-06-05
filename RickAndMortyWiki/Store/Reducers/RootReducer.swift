//
//  RootReducer.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//


struct RootReducer: ReduxReducer {
    let filterReducer: FilterReducer
    
    func reduce(state: AppState?,
                action: ReduxAction?) -> AppState {
        var state = state ?? AppState()
        state.filterState = filterReducer.reduce(state: state.filterState,
                                                  action: action)
        switch action {
        case let action as SetFilterCharacterAction:
            state.listState.characters = action.characters
        default : break
        }
       return state
    }
}
