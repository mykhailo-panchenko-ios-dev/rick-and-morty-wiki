//
//  FilterService.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 16.05.2025.
//

import Foundation
import Combine

protocol FilterCharacterService {
    func fetchFilters(filterCharacterRequest: FilterCharacterRequest) -> AnyPublisher<IFilterCharacterService.Response, NetworkError>
}

struct FilterCharacterRequest {
    private var name: String?
    private var status: Character.Status?
    private var species: String?
    private var gender: Character.Gender?
    private var page: Int = 1
    
    private var nameKey: String = "name"
    private var statusKey: String = "status"
    private var speciesKey: String = "species"
    private var genderKey: String = "gender"
    private var pageKey: String = "page"
    
    init(name: String? = nil,
         status: Character.Status? = nil,
         species: String? = nil,
         gender: Character.Gender? = nil,
         page: Int = 1) {
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.page = page
    }
    
    func createQueryParameters() -> [URLQueryItem] {
        var array: [URLQueryItem?] = []
        
        array.append(contentsOf: [
            createURLQueryItem(name: nameKey, value: name),
            createURLQueryItem(name: statusKey, value: status?.rawValue),
            createURLQueryItem(name: speciesKey, value: species),
            createURLQueryItem(name: genderKey, value: gender?.rawValue),
            createURLQueryItem(name: pageKey, value: String(page))
        ])
        return array.compactMap{ $0 }
    }
    
    private func createURLQueryItem(name: String, value: String?) -> URLQueryItem? {
        guard let value = value else { return nil }
        return URLQueryItem(name: name, value: value)
    }
}

class IFilterCharacterService: FilterCharacterService {
    let networkLayer: NetworkLayer
    var cancellables: Set<AnyCancellable> = []
    
    struct Response: Codable {
        let info: Info
        let results: [Character]
        
        struct Info: Codable {
            let count: Int
            let pages: Int
            let next: String?
        }
    }
    
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func fetchFilters(filterCharacterRequest: FilterCharacterRequest) -> AnyPublisher<Response, NetworkError> {
        networkLayer.fetch(from: .filterCharacters,
                           queryParameters: filterCharacterRequest.createQueryParameters(),
                           responseType: Response.self)
        
        .eraseToAnyPublisher()
    }
}

