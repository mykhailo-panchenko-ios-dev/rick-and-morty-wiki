//
//  FilterState.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//
import SwiftUI

struct FilterState: ReduxState {
    var name: String = ""
    var gender: String = ""
    var species: String = ""
    var status: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
}
