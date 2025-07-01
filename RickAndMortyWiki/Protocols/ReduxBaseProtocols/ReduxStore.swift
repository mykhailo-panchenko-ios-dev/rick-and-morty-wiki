//
//  ReduxStore.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

import Foundation

public protocol ReduxStore: ObservableObject {
    associatedtype State: ReduxState
    
    var state: State { get }
    
    func dispatch(_ action: ReduxAction)
}
