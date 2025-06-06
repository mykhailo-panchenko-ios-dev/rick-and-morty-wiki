//
//  Router.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 05.06.2025.
//

import SwiftUI

@MainActor
final class Router: ObservableObject {
    
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func view(for route: Route, store: AppStore) -> some View {
        switch route {
        case .filterScene:
            FilterView().environmentObject(store)
        case .charactersListScene:
            CharacterListView()
        }
    }
    
    func push(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

extension Router {
    enum Route {
        case filterScene
        case charactersListScene
    }
}
