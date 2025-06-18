//
//  RootReducer.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//


struct FetchMoreFilterCharacterRequestAction: ReduxAction {
   
}

struct RootReducer: ReduxReducer {
    let filterReducer: FilterReducer
    let charactersListReducer: CharactersListReducer
    
    func reduce(state: AppState?,
                action: ReduxAction?) -> AppState {
        var state = state ?? AppState()
        state.filterState = filterReducer.reduce(state: state.filterState,
                                                  action: action)
        state.charactersListState = charactersListReducer.reduce(state: state.charactersListState,
                                                                 action: action)
        switch action {
        case is SetFilterCharacterAction:
            state.isLoading = false
        case is StartFilterCharacterRequestAction, is FetchMoreFilterCharacterRequestAction:
            state.isLoading = true
        default : break
        }
       return state
    }
}
