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
            GeometryReader { geo in
                
                WithViewStore(store, observe: \.refreshScrollView) { viewStore in
                    RefreshableScrollView(axes: .vertical, showsIndicator: false, store: store.scope(state: \.refreshScrollView, action: Feature.Action.refreshScrollView)) {
                        
                        LazyVGrid(columns: column, alignment: .center, spacing: 4) {
                            Section {
                                WithViewStore(store, observe: { $0 }) { viewStore in
                                    ForEachStore(store.scope(state: \.item, action: Feature.Action.item)) {
                                        TaskItem.View(store: $0,
                                                      draggedTask: viewStore.state.currentlyTask,
                                                      isDragging: viewStore.state.dragging)
                                    }
                                }
                            } header: {
                                IfLetStore(store.scope(state: \.create, action: Feature.Action.create)) {
                                    TaskCreate.View(store: $0)
                                }
                            }
                        }
                        
                        .frame(height: geo.frame(in: .global).height, alignment: .top)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    } refresh: {
                        
                        IfLetStore(store.scope(state: \.plus, action: Feature.Action.plus)) {
                            TaskPlus.View(store: $0)
                        }
                        .foregroundStyle(.dark)
                        .frame(maxWidth: .infinity)
                        .frame(height: viewStore.state.refreshHeight * viewStore.state.progress, alignment: .bottom)
                        .opacity(viewStore.state.isScroll ? 1 : viewStore.isRefreshing ? 1 : 0)
                    }
                    .scrollIndicators(.hidden)
                }
                
            }
        }
        
    }
}
