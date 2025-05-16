//
//  FilterService.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 16.05.2025.
//

import Foundation
import Combine

protocol FilterService {
//    func fetchFilters() -> AnyPublisher<[Filter], Error>
    func fetchFilters() -> AnyPublisher<Response, NetworkError>
}
struct Response: Codable {
    let info: Info
    let results: [Character]
    
    struct Info: Codable {
        let count: Int
    }
}

class IFilterService : FilterService {
    let networkLayer: NetworkLayer
    var cancellables: Set<AnyCancellable> = []
    
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func fetchFilters() -> AnyPublisher<Response, NetworkError> {
        networkLayer.fethData(from: .filterCharacters,
                              queryParameters: [],
                              responseType: Response.self)
    }
    func run() {
        fetchFilters().sink { response in
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
