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
        
        @Namespace var namespace
        
        @State private var offset: CGFloat = .zero
        @State private var proxyOffset: CGPoint = .zero
        
        var body: some SwiftUI.View {
            GeometryReader { geo in
                WithViewStore(store, observe: \.task) { viewStore in
                    content(id: viewStore.id, title: viewStore.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .matchedGeometryEffect(id: viewStore.id, in: namespace)
                    .contentShape(.dragPreview, .rect(cornerRadius: 10))
                    .onDrag {
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
        private func content(id: UUID, title: String) -> some SwiftUI.View {
            ZStack {
                VStack {}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.green)
                
                
                GeometryReader { proxy in
                    VStack {
                        HStack() {
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
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                    .id(id)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(.lotion)
                        .shadow(radius: 8)
                    )
                    .offset(x: offset)
                    .gesture(
                        DragGesture(minimumDistance: 10)
                            .onChanged { value in
                                if value.translation.width > 0 {
                                    let axisX = value.location.x / (4.2)
                                    
                                    withAnimation {
                                        offset = axisX
                                    }
                                } else {
                                    let axisX = (proxy.frame(in: .local).maxX - value.location.x) / .pi
                                    
                                    withAnimation {
                                        offset = -axisX
                                    }
                                }

                                
                            }
                            .onEnded{ _ in
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



//                    .swipeActions(
//                        leading: [
//                            SwipeAction.Button(text: Text("Text"), action: {
//                                print("Text")
//                            }),
//                            SwipeAction.Button(
//                                icon: Image(systemName: "flag"), action: {
//                                    print("Flag")
//                                }, tint: .green)
//                        ],
//                        allowsFullSwipeLeading: true,
//                        trailing: [
//                            SwipeAction.Button(text: Text("Read"),
//                                              icon: Image(systemName: "envelope.open"),
//                                              action: {
//                                                  print("Read")
//                                              }, tint: .blue),
//                            SwipeAction.Button(icon: Image(systemName: "trash"), action: {
//                                print("Trash")
//                            }, tint: .red)
//                        ],
//                        allowsFullSwipeTrailing: true
//                    )
