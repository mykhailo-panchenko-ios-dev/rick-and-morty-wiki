//
//  ListView.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 09.05.2025.
//

import SwiftUI

struct CharacterListView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            contentView
        }
    }
    
    private var contentView: some View {
        VStack {
            ZStack {
                titleView
                backButton
            }
            listView
        }
    }
    
    private var backButton: some View {
        HStack(alignment: .center) {
            Button {
                router.pop()
            } label: {
                Image(systemName: "chevron.backward.circle.fill")
                    .resizable(resizingMode: .tile)
                    .foregroundColor(.detail)
                    .frame(width: 22, height: 22)
            }.growingButtonStyle(padding: 6)
                .padding(.leading)
                
            Spacer()
        }
    }
    
    private var titleView: some View {
        Text("Filter results:")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.text)
            .padding(12)
        
    }
    
    private var listView: some View {
        List(store.state.charactersListState.characters, id: \.id) { item in
            CharacterItemView(character: item)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .onAppear {
                    if store.state.charactersListState.characters.last?.id == item.id
                        && !store.state.charactersListState.maxPageReached {
                        store.dispatch(FetchMoreFilterCharacterRequestAction())
                    }
                }
        }
        .listStyle(.plain)
        .background(Color.background)
        .mask {
            LinearGradient(stops: [
                Gradient.Stop(color: .clear, location: 0),
                Gradient.Stop(color: .background, location: 0.05),
                Gradient.Stop(color: .background, location: 0.95),
                Gradient.Stop(color: .clear, location: 1)
            ], startPoint: .top, endPoint: .bottom)
        }
    }
}

#Preview {
    let networkLayer = NetworkLayer()
    let serviceBuilder = ServiceFactory(networkLayer: networkLayer)
    let store = Store(
        initialState: AppState(charactersListState: CharactersListState(),
                               filterState: FilterState()),
        rootReducer: RootReducer(filterReducer: FilterReducer(),
                                 charactersListReducer: CharactersListReducer()),
        middlewares: [FilterMiddleware(filterCharacterService: serviceBuilder.makeFilterService())])
    
    CharacterListView().environmentObject(store).environmentObject(Router())
}
