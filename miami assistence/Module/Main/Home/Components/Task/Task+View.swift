//
//  Task+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import SwiftUI


/// A preference key to store ScrollView offset
public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

extension Task {
    struct View: SwiftUI.View {
        
        @Environment(\.refresh) private var refresh
        @State private var isLoading = false // 1
        
        let store: StoreOf<Feature>
        let column: [GridItem] = [ .init(.flexible()) ]
        
        @State var progress: CGFloat = 0.0
        
        var body: some SwiftUI.View {
            GeometryReader {
                OffsettableScrollView {
                    
                    LazyVGrid(columns: column, alignment: .center, spacing: 4) {
                        IfLetStore(store.scope(state: \.create, action: Feature.Action.create)) {
                            TaskCreate.View(store: $0)
                        }
                        
                        WithViewStore(store, observe: { $0 }) { viewStore in
                            ForEachStore(store.scope(state: \.item, action: Feature.Action.item)) {
                                TaskItem.View(store: $0,
                                              draggedTask: viewStore.state.currentlyTask,
                                              isDragging: viewStore.state.dragging)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                } onRefresh: {
                    
                }
                .frame(height: abs($0.size.height - 80))
                .scrollIndicators(.hidden)
            }
        }
        
    }
}
