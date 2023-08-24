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
        
        @Environment(\.refresh) private var refresh
        @State private var isLoading = false // 1
        
        let store: StoreOf<Feature>
        let column: [GridItem] = [ .init(.flexible()) ]
        
        @State var progress: CGFloat = 0.0
        
        var body: some SwiftUI.View {
            GeometryReader { geo in
                RefreshableScrollView(axes: .vertical, showsIndicator: .hidden, store: store.scope(state: \.refreshScrollView, action: Feature.Action.refreshScrollView)) {
                    
                    LazyVStack {
                        IfLetStore(store.scope(state: \.create, action: Feature.Action.create)) {
                            TaskCreate.View(store: $0)
                        }
                        
                        LazyVStack(spacing: 4) {
                            ForEachStore(store.scope(state: \.item, action: Feature.Action.item)) {
                                TaskItem.View(store: $0)
                            }
                        }
                    }
                } refresh: {
                    IfLetStore(store.scope(state: \.plus, action: Feature.Action.plus)) {
                        TaskPlus.View(store: $0)
                    }
                }
                .frame(height: abs(geo.size.height - 80))
            }
            
        }
    }
    
    
}
