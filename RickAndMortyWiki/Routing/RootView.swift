//
//  RootView.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 05.06.2025.
//


import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        RouterView {
            FilterView()
        }
    }
}
