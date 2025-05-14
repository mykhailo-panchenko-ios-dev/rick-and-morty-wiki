//
//  ReduxStore.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 08.05.2025.
//

import Foundation

public protocol ReduxStore: ObservableObject {
    associatedtype S: ReduxState
    
    var state: S { get }
    
    func dispatch(_ action: ReduxAction)
}
