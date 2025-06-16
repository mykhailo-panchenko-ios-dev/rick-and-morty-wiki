//
//  CharacterItemView.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 06.06.2025.
//

import SwiftUI

struct CharacterItemView: View {
    
    let character: Character
    let unknownTitle = "Unknown"
    
    private var statusColor: Color {
        switch character.status {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown, .none:
            return .orange
        }
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.backgroundTextField.gradient)
                .shadow(color: statusColor, radius: 3)
                .overlay {
                    Capsule()
                        .stroke(.white, lineWidth: 1)
                }.padding(10)
            
            HStack {
                portretView
                personalInfoView
                Spacer()
                statusView
            }.padding(.horizontal, 20)
        }
    }
    
    private var personalInfoView: some View {
        VStack(alignment: .leading) {
            Text(character.name ?? unknownTitle)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.text)
            Text(character.gender?.rawValue ?? unknownTitle)
                .foregroundColor(.text)
        }.padding(.vertical, 10)
    }
    
    private var portretView: some View {
        AsyncImage(url: URL(string: character.image ?? "")) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "person.circle.fill")
                .foregroundColor(.white)
                .font(.system(size: 32))
        }
        .clipShape(.circle)
            .frame(width: 32, height: 32)
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 1)
                    .shadow(color: .black, radius: 3)
            }
    }
    
    private var statusView: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text("Status: \(character.status?.rawValue ?? unknownTitle)")
                    .foregroundColor(.text)
            }
            
            Image(systemName: "circle.hexagongrid.circle")
                .foregroundStyle(statusColor.secondary, .white)
                .font(.system(size: 32))
        }
    }
    
}

#Preview {
    let character = Character(name: "Rick Sanchez",
                              status: .alive,
                              species: nil,
                              type: nil,
                              gender: .male,
                              id: 1)
   
    CharacterItemView(character: character)
}
