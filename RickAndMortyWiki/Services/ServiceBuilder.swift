//
//  ServiceBuilder.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 19.05.2025.
//

import Foundation

class ServiceBuilder {
    func makeFilterService() -> FilterCharacterService {
        let filterCharacterService = IFilterCharacterService(networkLayer: NetworkLayer())
        return filterCharacterService
    }
}
