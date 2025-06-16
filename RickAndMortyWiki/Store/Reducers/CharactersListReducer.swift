//
//  ListReducer.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 09.06.2025.
//

struct CharactersListReducer: ReduxReducer {
    
    func reduce(state: CharactersListState?,
                action: ReduxAction?) -> CharactersListState {
        
        var state = state ?? CharactersListState()
        switch action {
        case is AddFilterCharactersDataAction:
            state = CharactersListState()
        case let action as SetFilterCharacterAction:
            guard state.characters.isEmpty else { break }
            state.characters = action.characters
            if state.currentPage == action.maxPage {
                state.maxPageReached = true
            } else {
                state.currentPage += 1
            }
        case let action as AppendFilterCharacterAction:
            state.characters.append(contentsOf: action.characters)
            if state.currentPage == action.maxPage {
                state.maxPageReached = true
            } else {
                state.currentPage += 1
            }
        default :
            break
        }
        return state
    }
}
