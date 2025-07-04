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
          RootReducer.State == AppState {
    
    @Published
    private(set) public var state: AppState

    private let rootReducer: RootReducer
    private var middlewares: [ReduxMiddleware]

    init(
        initialState: State,
        rootReducer: RootReducer,
        middlewares: [ReduxMiddleware]
    ) {
        self.state = initialState
        self.rootReducer = rootReducer
        self.middlewares = middlewares
    }

    public func dispatch(_ action: ReduxAction) {
        DispatchQueue.main.async {
            self.state = self.rootReducer.reduce(
                state: self.state,
                action: action
            )
        }
        self.middlewares.forEach {
            $0.dispatch(state: self.state,
                        action: action,
                        effectDispatch: self.dispatch
            )
        }
    }
}
