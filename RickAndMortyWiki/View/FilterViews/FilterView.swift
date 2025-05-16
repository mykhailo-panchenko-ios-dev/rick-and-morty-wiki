//
//  FilterView.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 09.05.2025.
//

import SwiftUI

struct FilterView: View {
    
//    @EnvironmentObject var store: AppStore
    
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
                                 placeholder: "Rick Sanchez")
                FilterTextFields(title: "Gender",
                                 placeholder: "Male")
                FilterTextFields(title: "Species",
                                 placeholder: "Human")
                FilterTextFields(title: "Status",
                                 placeholder: "Alive")
                Spacer()
            }
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 40) {
            titleAndSubtitleView
            backgroundDetailsView.frame(width: 500).offset(x: -110, y: 0)
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
            Button("Show list of characters") {
                
            }
            .growingButtonStyle().shadow(color:.buttonBackground, radius: 5).padding(.bottom, 20)
        }
    }
}

#Preview {
    FilterView()
}
