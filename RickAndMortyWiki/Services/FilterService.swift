//
//  FilterService.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 16.05.2025.
//

import Foundation
import Combine

protocol FilterCharacterService {
    func fetchFilters(filterCharacterRequest: FilterCharacterRequest) -> AnyPublisher<[Character], NetworkError>
}

struct FilterCharacterRequest {
    private var name: String?
    private var status: Character.Status?
    private var species: String?
    private var type: String?
    private var gender: Character.Gender?
    
    private var nameKey: String = "name"
    private var statusKey: String = "status"
    private var speciesKey: String = "species"
    private var typeKey: String = "type"
    private var genderKey: String = "gender"
    
    init(name: String? = nil,
         status: Character.Status? = nil,
         species: String? = nil,
         type: String? = nil,
         gender: Character.Gender? = nil) {
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
    }
    
    func createQueryParameters() -> [URLQueryItem] {
        var array: [URLQueryItem?] = []
        
        array.append(contentsOf: [
            createURLQueryItem(name: nameKey, value: name),
            createURLQueryItem(name: statusKey, value: status?.rawValue),
            createURLQueryItem(name: speciesKey, value: species),
            createURLQueryItem(name: typeKey, value: type),
            createURLQueryItem(name: genderKey, value: gender?.rawValue)
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
        }
    }
    
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func fetchFilters(filterCharacterRequest: FilterCharacterRequest) -> AnyPublisher<[Character], NetworkError> {
        networkLayer.fetch(from: .filterCharacters,
                           queryParameters: filterCharacterRequest.createQueryParameters(),
                              responseType: Response.self)
        .map { $0.results }
        .eraseToAnyPublisher()
    }
    
    func run() {
        fetchFilters(filterCharacterRequest: FilterCharacterRequest(name: "Rick", status: .alive, species: "Human")).sink { response in
            switch response {
            case .failure(let error):
                print(error)
            case .finished:
                print("Finished")
            }
        } receiveValue: { characters in
            print(characters)
        }.store(in: &cancellables)

    }
}
