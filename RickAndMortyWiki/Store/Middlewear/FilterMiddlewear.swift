//
//  FilterMiddlewear.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 19.05.2025.
//
import Foundation
import Combine

class FilterMiddleware: ReduxMiddleware {
    
    private var cancellables: Set<AnyCancellable> = []
    private let filterCharacterService: FilterCharacterService
    
    init(filterCharacterService: FilterCharacterService) {
        self.filterCharacterService = filterCharacterService
    }
    
    func dispatch(state: ReduxState,
                  action: ReduxAction,
                  effectDispatch: @escaping (ReduxAction) -> Void) {
        switch action {
         case is StartFilterCharacterRequestAction:
            guard let state = state as? AppState else {
                return
            }
            let filterCharacterRequest = FilterCharacterRequest(name: state.filterState.name,
                                                                status: nil,
                                                                species: state.filterState.species,
                                                                type: nil,
                                                                gender: nil)
            filterCharacterService.fetchFilters(filterCharacterRequest: filterCharacterRequest)
                .sink(receiveCompletion: { _ in }, receiveValue: { value in
                    print(value)
                    effectDispatch(SetFilterCharacterAction(characters: value))
                })
                .store(in: &cancellables)
        default :
            break
        }
    }
}

