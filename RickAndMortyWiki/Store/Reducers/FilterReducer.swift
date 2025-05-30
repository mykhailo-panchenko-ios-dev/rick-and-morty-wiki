//
//  FilterReducer.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 20.05.2025.
//

import Foundation

struct AddFilterCharactersDataAction: ReduxAction {
    let name: String
    let gender: String
    let species: String
    let status: String
}

struct StartFilterCharacterRequestAction: ReduxAction {
   
}

struct SetFilterCharacterAction: ReduxAction {
    let characters: [Character]
}

struct FilterReducer: ReduxReducer {
    
    func reduce(state: FilterState?,
                action: ReduxAction?) -> FilterState {
        var state = state
        switch action {
            case let action as AddFilterCharactersDataAction:
            state?.name = action.name
            state?.gender = Character.Gender(rawValue: action.gender)
            state?.species = action.species
            state?.status = Character.Status(rawValue: action.status)
         case is StartFilterCharacterRequestAction:
            state?.isLoading = true
        case is SetFilterCharacterAction:
            state?.isLoading = false
        default :
            break
        }
        return state ?? FilterState()
    }
}
