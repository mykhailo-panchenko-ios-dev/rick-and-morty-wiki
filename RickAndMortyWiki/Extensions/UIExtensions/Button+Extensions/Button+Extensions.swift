//
//  Button+Extensions.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 09.05.2025.
//
import SwiftUI


struct GrowingButton: ButtonStyle {
    var padding: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .background(Color.buttonBackground)
            .foregroundStyle(Color.tint)
            .fontWeight(.bold)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension View {
    public func growingButtonStyle(padding: CGFloat = 16) -> some View {
        self.buttonStyle(GrowingButton(padding: padding))
    }
}
