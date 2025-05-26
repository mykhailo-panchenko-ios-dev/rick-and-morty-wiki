//
//  ServiceBuilder.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 19.05.2025.
//

import Foundation

class ServiceFactory {
    var networkLayer: NetworkLayer
    
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func makeFilterService() -> FilterCharacterService {
        let filterCharacterService = IFilterCharacterService(networkLayer: NetworkLayer())
        return filterCharacterService
    }
}
