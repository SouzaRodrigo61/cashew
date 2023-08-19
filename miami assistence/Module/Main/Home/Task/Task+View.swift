//
//  Task+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import SwiftUI

extension Task {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        let column: [GridItem] = [ .init(.flexible()) ]
        
        var body: some SwiftUI.View {
            GeometryReader { geo in
                ScrollView {
                    LazyVGrid(columns: column, alignment: .leading, spacing: 4) {
                        WithViewStore(store, observe: { $0 }) { viewStore in
                            ForEach(viewStore.tasks) { item in
                                Text(item.title)
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 44)
                                    .foregroundStyle(.dark)
                                    .background(.white, in: .rect(cornerRadius: 10))
                                    .contentShape(.dragPreview, .rect(cornerRadius: 10))
                                    .overlay {
                                        if let dragging = viewStore.state.currentlyDragging, dragging.id == item.id, viewStore.state.draggingEffect {
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundStyle(.lotion)
                                        }
                                    }
                                    .draggable(item.id.uuidString) {
                                        Text(item.title)
                                            .padding(.horizontal, 16)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 44)
                                            .foregroundStyle(.dark)
                                            .background(.white)
                                            .contentShape(.dragPreview, .rect(cornerRadius: 10))
                                            .onAppear {
                                                store.send(.currentlyDragging(item))
                                            }
                                    }
                                    .dropDestination(for: String.self) { items, location in
                                        store.send(.removeCurrentlyDragging)
                                        return false
                                    } isTargeted: { status in
                                        if let currentlyDragging = viewStore.state.currentlyDragging, status, currentlyDragging.id != item.id {
                                            store.send(.dragged(item), animation: .snappy)
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .scrollIndicators(.hidden)
                .frame(height: abs(geo.size.height - 80))
            }
        }
    }
}
