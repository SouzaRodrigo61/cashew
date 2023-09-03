//
//  TaskItem+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import SwiftUI
import Foundation

enum GestureAnimation: CaseIterable {
    case leading
    case trailing
}

extension TaskItem {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        @Namespace var namespace
        
        @State private var offset: CGFloat = .zero
        @State private var proxyOffset: CGPoint = .zero
        
        @State private var colorRectangle: Color = .lotion
        @State private var colorView: Color = .clear
        
        @State private var gestureDirection: GestureAnimation = .leading
        
        var body: some SwiftUI.View {
            GeometryReader { geo in
                WithViewStore(store, observe: \.task) { viewStore in
                    content(id: viewStore.id, title: viewStore.title, leadingAction, trailingAction)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .matchedGeometryEffect(id: viewStore.id, in: namespace)
                    .contentShape(.dragPreview, .rect(cornerRadius: 10))
                    .onDrag {
                        store.send(.setCurrentlyDragged(viewStore.state))
                        return NSItemProvider()
                    } preview: {
                        Text(viewStore.title)
                            .matchedGeometryEffect(id: viewStore.id, in: namespace)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                            .frame(width: 200, alignment: .leading)
                            .foregroundStyle(.dark)
                            .background(.white, in: .rect(cornerRadius: 10))
                            .contentShape(.dragPreview, .rect(cornerRadius: 10))
                    }
                }
            }
        }
        
        
        @ViewBuilder
        private func content(id: UUID, title: String, _ leadingAction: @escaping () -> Void, _ trailingAction: @escaping () -> Void) -> some SwiftUI.View {
            ZStack {
                VStack {
                    Image(systemName: gestureDirection == .trailing ? "checkmark" : "zzz")
                        .padding(.horizontal, 8)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .offset(x: (offset / 4))
                        .animation(.spring(), value: offset)
                }
                .frame(maxWidth: .infinity, 
                       maxHeight: .infinity,
                       alignment: gestureDirection == .trailing ? .trailing : .leading)
                .background(colorRectangle)
                
                GeometryReader { proxy in
                    VStack {
                        HStack {
                            Image(systemName: "minus")
                                .accessibilityLabel("Item para force scroll")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.dark)
                                .padding(.leading, 16)
                            
                            Text(title)
                                .accessibilityLabel("Title do item")
                                .accessibilityHint("Item na lista \(title)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.dark)
                                .padding(.leading, 8)
                        }
                        .padding(.vertical, 8)
                    }
                    .id(id)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(
                        VStack {
                            RoundedRectangle(cornerRadius: 9.5)
                                .strokeBorder(colorView, lineWidth: 2)
                                .background(.lotion.shadow(.drop(radius: 7)), in: .rect(cornerRadius: 9.5))
                        }
                    )
                    .offset(x: offset)
                    .animation(.spring(), value: offset)
                    .gesture(
                        DragGesture(minimumDistance: 10)
                            .onChanged { value in
                                if value.translation.width > 0 {
                                    gestureDirection = .leading
                                    let axisX = (value.location.x - value.startLocation.x) / .pi
                                    
                                    withAnimation {
                                        colorRectangle = .cyan
                                        offset = axisX
                                    }
                                } else {
                                    gestureDirection = .trailing
                                    let axisX = (proxy.frame(in: .local).maxX - (value.location.x)) / 4.5
                                    
                                    withAnimation {
                                        colorRectangle = .green
                                        offset = -axisX
                                    }
                                }
                            }
                            .onEnded { value in
                                if value.translation.width > 0 {
                                    let axisX = (value.location.x - value.startLocation.x) / .pi

                                    if axisX > 40 {
                                        
                                        withAnimation {
                                            colorView = .cyan.opacity(0.5)
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                colorView = .lotion
                                            }
                                            
                                            leadingAction()
                                        }
                                    }
                                } else {
                                    let axisX = (proxy.frame(in: .local).maxX - (value.location.x)) / 4.5
                                    
                                    if axisX > 40 {
                                        withAnimation {
                                            colorView = .green.opacity(0.5)
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                colorView = .lotion
                                            }
                                            
                                            trailingAction()
                                        }
                                    }
                                }
                                
                                withAnimation(.bouncy) {
                                    offset = .zero
                                }
                            }
                    )
                }
            }
        }
        
        
        private func leadingAction() {
            dump("Leading")
        }
        
        private func trailingAction() {
            dump("Trailing")
        }
    }
}
