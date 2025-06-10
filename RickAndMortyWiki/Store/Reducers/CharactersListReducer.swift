//
//  ListReducer.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 09.06.2025.
//

struct CharactersListReducer: ReduxReducer {
    
    func reduce(state: CharactersListState?,
                action: ReduxAction?) -> CharactersListState {
        var state = state
        switch action {
        case is AddFilterCharactersDataAction:
            state = CharactersListState()
        case let action as SetFilterCharacterAction:
            state?.characters.append(contentsOf: action.characters)
            if state?.currentPage == action.maxPage {
                state?.maxPageReached = true
            } else {
                state?.currentPage += 1
            }
        default :
            break
        }
        return state ?? CharactersListState()
    }
}
