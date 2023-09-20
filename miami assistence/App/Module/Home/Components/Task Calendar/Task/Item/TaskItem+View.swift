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
        
        @State private var disableAnimation: Bool = true
        
        @State private var offset: CGFloat = .zero
        @State private var proxyOffset: CGPoint = .zero
        
        @State private var colorRectangle: Color = .lotion
        @State private var colorView: Color = .clear
        
        @State private var gestureDirection: GestureAnimation = .leading
        
        var body: some SwiftUI.View {
            GeometryReader { geo in
                WithViewStore(store, observe: \.task) { viewStore in
                    content(id: viewStore.id, title: viewStore.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(.dragPreview, .rect(cornerRadius: 10))
                        .onDrag {
                            store.send(.setCurrentlyDragged(viewStore.state))
                            return NSItemProvider()
                        } preview: {
                            Text(viewStore.title)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 16)
                                .frame(width: 200, alignment: .leading)
                                .foregroundStyle(.dark)
                                .background(.white, in: .rect(cornerRadius: 10))
                                .contentShape(.dragPreview, .rect(cornerRadius: 10))
                        }
                        .onTapGesture {
                            store.send(.contentTapped(viewStore.state))
                        }
                }
            }
        }
        
        
        @ViewBuilder
        private func content(
            id: UUID,
            title: String
        ) -> some SwiftUI.View {
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
                    Content(id: id, title: title, color: colorView)
                        .offset(x: offset)
                        .animation(.spring(), value: offset)
                        .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                            return [id.uuidString: anchor]
                        })
                        .gesture(
                            DragGesture(minimumDistance: 5)
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
                                        if value.startLocation.x > proxy.frame(in: .local).midX {
                                            let axisX = (proxy.frame(in: .local).maxX - (value.location.x)) / .pi
                                            
                                            withAnimation {
                                                colorRectangle = .green
                                                offset = -axisX
                                            }
                                        } else {
                                            let axisX = (value.startLocation.x - value.location.x) / .pi
                                            
                                            withAnimation {
                                                colorRectangle = .green
                                                offset = -axisX
                                            }
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
                                            }
                                            
                                            store.send(.leadingAction(id), animation: .default)
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
                                            }
                                            
                                            store.send(.trailingAction(id), animation: .default)
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
    }
    
    struct Content: SwiftUI.View {
        let id: UUID
        let title: String
        let color: Color
        
        let alignment: Alignment
        let showOverlay: Bool
        let forcePadding: Bool
        
        init(id: UUID, title: String, color: Color, alignment: Alignment = .leading, showOverlay: Bool = true, forcePadding: Bool = false) {
            self.id = id
            self.title = title
            self.color = color
            self.alignment = alignment
            self.showOverlay = showOverlay
            self.forcePadding = forcePadding
        }
        
        
        var body: some SwiftUI.View {
            VStack {
                HStack {
                    if showOverlay {
                        Image(systemName: "minus")
                            .accessibilityHint("task.item.accessibility.image.hint")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.dark)
                            .padding(.leading, 16)
                    }
                                        
                    Text(title)
                        .accessibilityLabel("task.item.accessibility.text.label")
                        .accessibilityHint("task.item.accessibility.text.hint \(title)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.dark)
                        .padding(.leading, 8)
                        .padding(.leading, forcePadding ? 40 : 0)
                }
                .padding(.vertical, 8)
            }
            .id(id)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .background(
                VStack {
                    if showOverlay {
                        RoundedRectangle(cornerRadius: 9.5)
                            .strokeBorder(color, lineWidth: 2)
                            .background(Color.lotion.shadow(.drop(radius: 7)), in: .rect(cornerRadius: 9.5))
                    }
                }
            )
        }
    }
}
