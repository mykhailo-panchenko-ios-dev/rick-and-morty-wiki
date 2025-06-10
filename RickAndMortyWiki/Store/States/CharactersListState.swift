//
//  ListState.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

struct CharactersListState: ReduxState {
    var characters: [Character] = []
    var currentPage: Int = 1
    var maxPageReached: Bool = false
}
