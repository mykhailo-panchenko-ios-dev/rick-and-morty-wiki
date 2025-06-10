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
         case is StartFilterCharacterRequestAction, is FetchFilterCharacterPageRequestAction:
            guard let state = state as? AppState else {
                return
            }
            let filterCharacterRequest = FilterCharacterRequest(name: state.filterState.name,
                                                                status: state.filterState.status,
                                                                species: state.filterState.species,
                                                                gender: state.filterState.gender,
                                                                page: state.charactersListState.currentPage)
            filterCharacterService.fetchFilters(filterCharacterRequest: filterCharacterRequest)
                .sink(receiveCompletion: { result in
                    
                }, receiveValue: { value in
                    print(value.info)
                    effectDispatch(SetFilterCharacterAction(characters: value.results, maxPage: value.info.pages))
                })
                .store(in: &cancellables)
        default :
            break
        }
    }
}

