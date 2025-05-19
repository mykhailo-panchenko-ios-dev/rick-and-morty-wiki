//
//  FilterMiddlewear.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 19.05.2025.
//
import Foundation
import Combine

class FilterMiddleware: ReduxMiddleware {
    func dispatch(_ action: ReduxAction, effectDispatch: @escaping (ReduxAction) -> Void) {
//        switch action {
//        case :
            
//        }
    }
    
    let filterCharacterService: FilterCharacterService
    
    init(filterCharacterService: FilterCharacterService) {
        self.filterCharacterService = filterCharacterService
    }
    
}

