//
//  ListView.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 09.05.2025.
//

import SwiftUI

struct CharacterListView: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            contentView
        }
    }
    
    private var contentView: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CharacterListView()
}
