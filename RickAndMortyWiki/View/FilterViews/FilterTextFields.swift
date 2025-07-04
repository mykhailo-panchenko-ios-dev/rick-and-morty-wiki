//
//  Untitled.swift
//  RickAndMortyWiki
//
//  Created by Mike Panchenko on 13.05.2025.
//

import SwiftUI


struct FilterTextFields: View {
    
    @State private var animationStart: Bool = false
    @State private var pickerSelected: Bool = false

    let title: String
    let placeholder: String
    let pickerItems: [String]

    @Binding var field: String
    
    init(title: String,
         placeholder: String,
         field: Binding<String>,
         pickerItems: [String] = []) {
        self.title = title
        self.placeholder = placeholder
        self._field = field
        self.pickerItems = pickerItems
    }
    
    var body: some View {
        StoppingPhaseAnimator(AnimationPhase.allCases,
                              trigger: animationStart) { phase in
            ZStack {
                
                animatedTitleViews
                    .offset(x: phase.xOffset,
                            y: phase.yOffset)
                textFieldBackground(phase: phase)
                textFieldView(phase: phase)
                    .frame(width: phase.textFieldWidth,
                           height: 44,
                           alignment: .leading)
                    .offset(x: phase.xOffsetTextField,
                            y: phase.yOffsetTextField)
                    .padding(.vertical, 20)
                if !field.isEmpty {
                    clearButtonView(phase: phase)
                }
            }.rotationEffect(.degrees(phase.rotationDegree))
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.2)) {
                        pickerSelected.toggle()
                    }
                }
        } animation: { phase in
            switch phase {
            case .initial, .rotate:
                    .smooth(extraBounce: 0.4)
                
            case .animating:
                    .spring(bounce: 0.7)
            case .final:
                    .snappy(extraBounce: 0.30)
            }
        }.onAppear {
            animationStart = true
        }.offset(x: -110, y: 0)
    }
    @ViewBuilder
    private func clearButtonView(phase: AnimationPhase) -> some View {
        Button {
            field = ""
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(Color.red.secondary)
                .opacity(phase == .final ? 1 : 0)
                
        }.offset(x: phase.xOffsetTextFieldBackgound + phase.textFieldWidth/2,
                y: phase.yOffsetTextField)
    }
    
    @ViewBuilder
    private func textFieldBackground(phase: AnimationPhase) -> some View {
        Capsule()
            .fill(Color.backgroundTextField)
            .frame(width: phase.textFieldBackgroundWidth,
                   height: 44)
            .shadow(radius: 3)
            .offset(x: phase.xOffsetTextFieldBackgound,
                    y: phase.yOffsetTextField)
    }
    
    @ViewBuilder
    private func textFieldView(phase: AnimationPhase) -> some View {
        if !pickerItems.isEmpty {
            if pickerSelected {
                Picker("", selection: $field) {
                    ForEach(pickerItems, id: \.self) { item in
                        Text(item)
                    }
                }.pickerStyle(.segmented)
                    .onChange(of: field) {
                        withAnimation(.easeOut(duration: 0.2)) {
                            pickerSelected.toggle()
                        }
                    }
            } else {
                if field.isEmpty {
                    Text(phase == .final ? placeholder :"").foregroundStyle(PlaceholderTextShapeStyle())
                }
                Text(field)
            }
        } else {
            TextField(phase == .final ? placeholder :"",
                      text: $field)
        }
    }
    
    private var animatedTitleViews: some View {
        ZStack {
            Capsule()
                .fill(Color.detail.gradient)
                .padding()
                .frame(width: 200, height: 100)
                .rotationEffect(.degrees(-45))
                .shadow(radius: 10, x: 10)
            Text(title)
                .rotationEffect(.degrees(-45))
                .offset(x: -30, y: 30)
                .foregroundColor(.text)
                .bold()
                .shadow(color: .backgroundTextField,
                        radius: 2,
                        x: 3)
        }
    }
}

extension FilterTextFields {
    private enum AnimationPhase: CaseIterable {
        case initial
        case rotate
        case animating
        case final
        
        var yOffset: CGFloat {
            switch self {
            case .initial:
                100
            case .animating, .final, .rotate:
                0
            }
        }
        
        var xOffset: CGFloat {
            switch self {
            case .initial:
                -100
            case .animating, .final, .rotate:
                0
            }
        }
        
        var yOffsetTextField: CGFloat {
            switch self {
            case .initial:
                65
            case .animating, .rotate, .final:
                -35
            }
        }
        
        var xOffsetTextField: CGFloat {
            switch self {
            case .initial:
                -65
            case .animating, .rotate:
                35
            case .final:
                130
            }
        }
        
        var xOffsetTextFieldBackgound: CGFloat {
            switch self {
            case .initial:
                -65
            case .animating, .rotate:
                35
            case .final:
                140
            }
        }
        
        var rotationDegree: CGFloat {
            switch self {
            case .initial:
                45
            case .rotate:
                30
            case .animating, .final:
                0
            }
        }
        
        var textFieldWidth: CGFloat {
            switch self {
            case .initial, .rotate:
                return 44
                case .animating:
                return 36
            case .final:
                return 214
            }
        }
        var textFieldBackgroundWidth: CGFloat {
            switch self {
            case .initial, .rotate:
                return 44
                case .animating:
                return 36
            case .final:
                return 250
            }
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    FilterTextFields(title: "Gender",
                     placeholder: "Male",
                     field: $text)
}
