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
        
        @State var offset: CGFloat = .nan

        @State private var axisY: CGFloat = .nan
        
        var body: some SwiftUI.View {
            
            List {
                ForEachStore(store.scope(state: \.item, action: Feature.Action.item)) {
                    TaskItem.View(store: $0)
                }
                .onMove { _, _ in }
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
                .listRowBackground(Color.alabaster)
                
                WithViewStore(store, observe: \.showCreateTask) { viewStore in
                    if viewStore.state {
                        Button {
                            store.send(.showTaskCreate, animation: .bouncy)
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "plus.square.dashed")
                                    .font(.system(.title, design: .rounded))
                                    .foregroundStyle(.royalBlue)
                                
                                Text("task.button.create.title")
                                    .font(.system(.body, design: .rounded))
                            }
                            .hSpacing(.leading)
                            .padding(.horizontal, 8)
                        }
                        .buttonStyle(.scale)
                        .listRowInsets(.init())
                    }
                }
                
            }
            .coordinateSpace(name: "SCROLL")
            .accessibilityLabel("Lista de dados")
            .contentMargins(8, for: .scrollContent)
            .listRowSpacing(8)
            .scrollIndicators(.hidden)
            .environment(\.defaultMinListRowHeight, 64)
            .scrollContentBackground(.hidden)
        }
        
    }
}
