//
//  Store.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

import Foundation
import Combine

class Store<AppState, RootReducer>: ReduxStore
    where RootReducer: ReduxReducer,
    RootReducer.S == AppState {
    
    @Published
    private(set) public var state: AppState

    private let rootReducer: RootReducer

    init(
        initialState: S,
        rootReducer: RootReducer
    ) {
        self.state = initialState
        self.rootReducer = rootReducer
    }

    public func dispatch(_ action: ReduxAction) {
        state = rootReducer.reduce(
            state: state,
            action: action
        )
    }
}
