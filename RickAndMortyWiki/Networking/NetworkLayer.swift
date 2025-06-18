//
//  NetworkService.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 16.05.2025.
//
import Foundation
import Combine

protocol NetworkLayerProtocol {
    func fetch<D: Codable> (
        from: RickAndMortyApiURL,
        queryParameters: [URLQueryItem],
        responseType: D.Type) -> AnyPublisher<D, NetworkError>
}

enum RickAndMortyApiURL {
    case filterCharacters
    
    func getPath() -> String {
        let api = "https://rickandmortyapi.com/api"
        switch self {
        case .filterCharacters:
            return "\(api)/character"
        }
    }
}

struct ErrorMessages: Decodable {
    let error: String
}

class NetworkLayer: NetworkLayerProtocol {
    func fetch<D: Codable> (
        from: RickAndMortyApiURL,
        queryParameters: [URLQueryItem],
        responseType: D.Type) -> AnyPublisher<D, NetworkError> {
            var urlComponent = URLComponents(string: from.getPath())
            urlComponent?.queryItems = queryParameters
            guard let url = urlComponent?.url else {
                return Fail(error: .invalidURL).eraseToAnyPublisher()
            }
            return Future<D, NetworkError> { promise in
                URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                    if let error = error {
                        NetworkLogger.logError(error)
                        promise(.failure(.urlError))
                    } else if let data = data {
                        do {
                            let decodedData = try JSONDecoder().decode(responseType, from: data)
                            promise(.success(decodedData))
                        } catch {
                            do {
                                let decodedData = try JSONDecoder().decode(ErrorMessages.self, from: data)
                                promise(.failure(.apiError(decodedData.error)))
                            } catch {
                                NetworkLogger.logError(.decodeError)
                                promise(.failure(.decodeError))
                            }
                        }
                        
                    } else {
                        promise(.failure(.invalidResponse))
                    }
                }.resume()
            }.eraseToAnyPublisher()
        }
}
