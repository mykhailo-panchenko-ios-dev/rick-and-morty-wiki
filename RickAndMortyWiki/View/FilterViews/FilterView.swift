//
//  FilterView.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 09.05.2025.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var store: AppStore
    private struct FilterData: Equatable {
        var name: String = ""
        var gender: String = ""
        var species: String = ""
        var status: String = ""
    }
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
    
    private var contentView: some View {
        VStack(spacing: 40) {
            titleAndSubtitleView
            backgroundDetailsView
                .frame(width: 500)
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
            Button(store.state.filterState.isLoading ? "Loading...": "Show list of characters") {
                store.dispatch(StartFilterCharacterRequestAction())
            }
            .growingButtonStyle().shadow(color:.buttonBackground, radius: 5).padding(.bottom, 20)
        }
    }
}

#Preview {
    let networkLayer = NetworkLayer()
    let serviceBuilder = ServiceFactory(networkLayer: networkLayer)
    let store = Store(
        initialState: AppState(listState: ListState(),
                               filterState: FilterState()),
        rootReducer: RootReducer(filterReducer: FilterReducer()),
        middlewares: [FilterMiddleware(filterCharacterService: serviceBuilder.makeFilterService())])
    
    FilterView().environmentObject(store)
}
