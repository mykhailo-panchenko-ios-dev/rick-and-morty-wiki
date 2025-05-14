//
//  ReduxReduce.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

public protocol ReduxReducer {
    associatedtype S: ReduxState

    func reduce(state: S?, action: ReduxAction?) -> S
}
