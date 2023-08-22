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
                            ForEachStore(store.scope(
                                state: \.item,
                                action: Feature.Action.item
                            )) {
                                TaskItem.View(store: $0,
                                              draggedTask: viewStore.state.currentlyTask,
                                              isDragging: viewStore.state.dragging)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .onAppear {
                    store.send(.reOrdering)
                }
                .scrollIndicators(.hidden)
                .frame(height: abs(geo.size.height - 80))
            }
        }
    }
}
