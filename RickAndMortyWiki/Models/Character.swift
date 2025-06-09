//
//  Character.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 16.05.2025.
//

import Foundation

struct Character: Codable {
    enum Status: String, Codable, CaseIterable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    enum Gender: String, Codable, CaseIterable {
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown
    }
    
    var name: String?
    var status: Status?
    var species: String?
    var type: String?
    var gender: Gender?
    var id: Int
}
