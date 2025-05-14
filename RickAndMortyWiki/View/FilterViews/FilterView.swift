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
            contentView
            backgroundDetailsView
        }
    }
    
    private var backgroundDetailsView: some View {
        HStack{
            ZStack {
                FilterTextFields()
                    .offset(y: -135)
                    .transition(.slide)
                FilterTextFields()
                    .transition(.slide)
                FilterTextFields()
                    .offset(y: 135)
            }
            .padding(.leading, -60)
            Spacer()
        }
       
    }
    
    private var contentView: some View {
        VStack {
            titleAndSubtitleView
            Spacer()
            submitButton
        }
    }
    
    private var titleAndSubtitleView: some View {
        VStack(alignment: .leading) {
            Text("Filter")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.text)
            Text("Select filters here")
                .font(.callout)
                .foregroundColor(.text)
        }.padding(.horizontal, 20)
        
    }
    
    private var submitButton: some View {
        ZStack {
            Button("Show list of characters") {
                
            }.growingButtonStyle()
            
        }
        
    }
}

#Preview {
    FilterView()
}
