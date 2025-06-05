//
//  RouterView.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 05.06.2025.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @inlinable
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) {
                    router.view(for: $0, store: store)
                        .navigationBarBackButtonHidden()
                }
        }
        .environmentObject(router)
    }

    @StateObject private var router = Router()
    @EnvironmentObject var store: AppStore
    private let content: Content
}
