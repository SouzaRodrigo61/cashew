//
//  TaskItem+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import SwiftUI
import Foundation

extension TaskItem {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        @State var disableAnimation: Bool = true
        @State var offset: CGFloat = .zero
        @State var proxyOffset: CGPoint = .zero
        @State var colorRectangle: Color = .lotion
        @State var colorView: Color = .clear
        
        var body: some SwiftUI.View {
            GeometryReader { geo in
                WithViewStore(store, observe: \.task) { viewStore in
                    content(id: viewStore.id, task: viewStore.state)
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
            task: Task.Model
        ) -> some SwiftUI.View {
            ZStack {
                HStack {
                    Image(systemName: "zzz")
                        .padding(.leading, 12)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .offset(x: offset / 4)
                        .animation(.spring(), value: offset)
                    Spacer()
                    Image(systemName: "checkmark")
                        .padding(.trailing, 12)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .offset(x: offset / 4)
                        .animation(.spring(), value: offset)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(colorRectangle)
                
                GeometryReader { proxy in
                    Content(id: id, task: task, color: colorView)
                        .offset(x: offset)
                        .animation(.spring(), value: offset)
                        .anchorPreference(key: MAnchorKey.self, value: .bounds) {
                            return [id.uuidString: $0]
                        }
                        .gesture(
                            DragGesture(minimumDistance: 10)
                                .onChanged { value in
                                    if value.translation.width > 0 {
                                        let axisX = (value.location.x - value.startLocation.x) / .pi
                                        
                                        withAnimation {
                                            colorRectangle = .cyan
                                            offset = axisX
                                        }
                                    } else {
                                        if value.startLocation.x > proxy.frame(in: .local).midX {
                                            let axisX = (proxy.frame(in: .local).maxX - value.location.x) / .pi
                                            
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
                                            
                                            store.send(.leadingAction(id))
                                        }
                                    } else {
                                        let axisX = (proxy.frame(in: .local).maxX - value.location.x) / 4.5
                                        
                                        if axisX > 40 {
                                            
                                            dump(axisX, name: "axisX")
                                            
                                            withAnimation {
                                                colorView = .green.opacity(0.5)
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                withAnimation {
                                                    colorView = .lotion
                                                }
                                            }
                                            
                                            store.send(.trailingAction(id))
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
}
