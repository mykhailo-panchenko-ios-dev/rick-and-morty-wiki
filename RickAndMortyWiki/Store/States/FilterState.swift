//
//  FilterState.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//
import SwiftUI

struct FilterState: ReduxState {
    var name: String = ""
    var gender: Character.Gender?
    var species: String = ""
    var status: Character.Status?
    var errorMessage: String?
    let genders = Character.Gender.allCases.map { $0.rawValue }
    let statuses = Character.Status.allCases.map { $0.rawValue }
    var startFilterRequestIsLoading: Bool = false
    var networkError: String?
}
