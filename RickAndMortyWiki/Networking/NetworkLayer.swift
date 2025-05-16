//
//  NetworkService.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 16.05.2025.
//
import Foundation
import Combine

protocol NetworkLayer {
    func fethData<D: Codable> (
        from: URLs,
        queryParameters: [URLQueryItem],
        responseType: D.Type) -> AnyPublisher<D, NetworkError>
}

enum NetworkError: Error {
    case urlError
    case invalidResponse
    case invalidURL
    case decodeError
}

enum URLs {
    case filterCharacters
    
    func getPath() -> String {
        let api = "https://rickandmortyapi.com/api"
        switch self {
        case .filterCharacters:
            return "\(api)/character"
        }
    }
}

class INetworkLayer: NetworkLayer {
    func fethData<D: Codable> (
        from: URLs,
        queryParameters: [URLQueryItem],
        responseType: D.Type) -> AnyPublisher<D, NetworkError> {
            var urlComponent = URLComponents(string: URLs.filterCharacters.getPath())
            urlComponent?.queryItems = queryParameters
            guard let url = urlComponent?.url else {
                return Fail(error: .invalidURL).eraseToAnyPublisher()
            }
            return Future<D, NetworkError> { promise in
                URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                    if let error = error {
                        print("Responce at \(Date()) with error: \(error)")
                        promise(.failure(.urlError))
                    } else if let data = data {
                        do {
                            let decodedData = try JSONDecoder().decode(responseType, from: data)
                            promise(.success(decodedData))
                        } catch let error {
                            print("Decoding at \(Date()) with error: \(error)")
                            promise(.failure(.decodeError))
                        }
                        
                    } else {
                        promise(.failure(.invalidResponse))
                    }
                }.resume()
            }.eraseToAnyPublisher()
        }
}
