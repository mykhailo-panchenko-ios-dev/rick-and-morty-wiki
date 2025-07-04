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
                                                                status: state.filterState.status,
                                                                species: state.filterState.species,
                                                                gender: state.filterState.gender)
            filterCharacterService.fetchFilters(filterCharacterRequest: filterCharacterRequest)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let failure):
                        effectDispatch(ErrorFilterCharacterAction(error: failure))
                    }
                }, receiveValue: { value in
                    effectDispatch(SetFilterCharacterAction(characters: value.results,
                                                            maxPage: value.info.pages))
                })
                .store(in: &cancellables)
        case is FetchMoreFilterCharacterRequestAction:
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
                    effectDispatch(AppendFilterCharacterAction(characters: value.results,
                                                               maxPage: value.info.pages))
                })
                .store(in: &cancellables)
        default :
            break
        }
    }
}

