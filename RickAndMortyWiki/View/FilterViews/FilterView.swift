//
//  FilterView.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 09.05.2025.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject var store: AppStore
    @State private var filterData: FilterData = FilterData()
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.vertical) {
                contentView
            }
            submitButton.frame(alignment: .bottom)
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 40) {
            titleAndSubtitleView
            backgroundDetailsView
                .frame(width: 500)
        }
    }
    
    private var backgroundDetailsView: some View {
        HStack {
            VStack(spacing: 40) {
                FilterTextFields(title: "Name",
                                 placeholder: "Rick Sanchez",
                                 field: $filterData.name)
                FilterTextFields(title: "Gender",
                                 placeholder: "Male",
                                 field: $filterData.gender,
                                 pickerItems: store.state.filterState.genders)
                FilterTextFields(title: "Species",
                                 placeholder: "Human",
                                 field: $filterData.species)
                FilterTextFields(title: "Status",
                                 placeholder: "Alive",
                                 field: $filterData.status,
                                 pickerItems: store.state.filterState.statuses)
                Spacer()
            }.onChange(of: filterData) {
                store.dispatch(AddFilterCharactersDataAction(name: filterData.name,
                                                             gender: filterData.gender,
                                                             species: filterData.species,
                                                             status: filterData.status))
            }
        }
    }
    
    private var titleAndSubtitleView: some View {
        VStack(alignment: .leading) {
            Text("Filter")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.text)
            Text("Select parameters to filter characters")
                .font(.callout)
                .foregroundColor(.text)
        }.padding(.horizontal, 20)
        
    }
    
    private var submitButton: some View {
        VStack{
            Spacer()
            Button(store.state.filterState.startFilterRequestIsLoading ? "Loading...": "Show list of characters") {
                store.dispatch(StartFilterCharacterRequestAction())
            }.onChange(of: store.state.filterState.startFilterRequestIsLoading, { oldValue, newValue in
                if oldValue == true && newValue == false && store.state.filterState.networkError == nil {
                    router.push(.charactersListScene)
                }
            })
            .growingButtonStyle().shadow(color:.buttonBackground, radius: 5)
            .padding(.bottom, 20)
            if store.state.filterState.networkError != nil {
                Text(store.state.filterState.networkError ?? "")
                .foregroundColor(.red)
                .overlay {
                    Capsule()
                        .stroke(.red, lineWidth: 1)
                        .shadow(color: .black, radius: 2)
                        .padding(-8)
                }
                .background {
                    Capsule(style: .continuous)
                        .fill(Color.white)
                        .padding(-8)
                }
                .opacity(store.state.filterState.networkError != nil ? 1 : 0)
                .padding(.bottom, 20)
            }
            
        }
    }
}

extension FilterView {
    private struct FilterData: Equatable {
        var name: String = ""
        var gender: String = ""
        var species: String = ""
        var status: String = ""
    }
}

#Preview {
    let networkLayer = NetworkLayer()
    let serviceBuilder = ServiceFactory(networkLayer: networkLayer)
    let store = Store(
        initialState: AppState(charactersListState: CharactersListState(),
                               filterState: FilterState()),
        rootReducer: RootReducer(filterReducer: FilterReducer(), charactersListReducer: CharactersListReducer()),
        middlewares: [FilterMiddleware(filterCharacterService: serviceBuilder.makeFilterService())])
    
    FilterView().environmentObject(store).environmentObject(Router())
}
