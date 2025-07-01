//
//  Untitled.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 13.05.2025.
//
import SwiftUI


struct StoppingPhaseAnimator<Phase, Content, Trigger> : View where Phase : Equatable, Content : View, Trigger: Equatable {
   private let phases: [Phase]
   private let trigger: Trigger
   private let content: (Phase) -> Content
   private let animation: (Phase) -> Animation?
    
    @State var lastTrigger: Trigger?
    
    init(_ phases: [Phase],
         trigger: Trigger,
         @ViewBuilder content: @escaping (Phase) -> Content,
         animation: @escaping (Phase) -> Animation? = { _ in .default }) {
        self.phases = phases
        self.trigger = trigger
        self.content = content
        self.animation = animation
    }
    
    func stoppingContent(phase: Phase) -> Content {
        var stoppingPhase = phase
        
        if phase == phases[0] {
            if let lastTrigger,
                trigger == lastTrigger {
                stoppingPhase = phases.last!
            } else {
                stoppingPhase = phase
            }
        } else {
            DispatchQueue.main.async {
                lastTrigger = trigger
            }
        }

        return content(stoppingPhase)
    }
    
    var body: some View {
        PhaseAnimator(phases,
                      trigger: trigger,
                      content: stoppingContent,
                      animation: animation)
    }
}
