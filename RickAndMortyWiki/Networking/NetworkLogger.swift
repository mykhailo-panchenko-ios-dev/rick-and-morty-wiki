//
//  NetworkLogger.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 19.05.2025.
//
import Foundation


enum NetworkError: Error {
    case urlError
    case invalidResponse
    case invalidURL
    case decodeError
    case unknown
    case apiError(String)
}

class NetworkLogger {
    static func logError(_ error: NetworkError) {
        print("\(Date()) Network error: \(error)")
    }
    
    static func logError(_ error: Error) {
        let error = error as? NetworkError
        print("\(Date()) Network error: \(error ?? .unknown)")
    }
}
