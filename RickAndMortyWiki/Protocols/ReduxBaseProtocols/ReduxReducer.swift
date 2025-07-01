//
//  ReduxReduce.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

public protocol ReduxReducer {
    associatedtype State: ReduxState

    func reduce(state: State?, action: ReduxAction?) -> State
}
