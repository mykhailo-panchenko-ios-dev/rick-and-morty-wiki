//
//  ReduxMiddlewear.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 19.05.2025.
//

import Foundation

protocol ReduxMiddleware {
    
    func dispatch(state: ReduxState,
                  action: ReduxAction,
                  effectDispatch: @escaping (ReduxAction) -> Void)
}
