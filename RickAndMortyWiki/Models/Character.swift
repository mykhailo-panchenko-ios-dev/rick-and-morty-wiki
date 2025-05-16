//
//  Character.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 16.05.2025.
//

import Foundation

struct Character: Codable {
    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    enum Gender: String, Codable {
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown
    }
    
    private var name: String?
    private var status: Status?
    private var species: String?
    private var type: String?
    private var gender: Gender?
}


