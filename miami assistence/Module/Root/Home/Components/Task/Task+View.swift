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
            GeometryReader { geo in
                List {
                    ForEachStore(store.scope(state: \.item, action: Feature.Action.item)) {
                        TaskItem.View(store: $0)
                    }
                    .onMove { _, _ in }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    .listRowBackground(Color.alabaster)
                    
                    IfLetStore(store.scope(state: \.empty, action: Feature.Action.empty)) { _ in
                        TaskEmpty.View()
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    
                    Button {
                        store.send(.showTaskCreate, animation: .easeIn)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "calendar.badge.plus")
                                .font(.system(.title, design: .rounded))
                                .foregroundStyle(.royalBlue)
                            Text("task.list.label.create")
                                .foregroundStyle(.dark)
                                .font(.system(.title3, design: .rounded))
                        }
                        .padding(.horizontal, 8)
                    }
                    .listRowInsets(.init())
                    .buttonStyle(.scale)
                }
                .coordinateSpace(name: "SCROLL")
                .accessibilityLabel("Lista de dados")
                .contentMargins(8, for: .scrollContent)
                .listRowSpacing(8)
                .scrollIndicators(.hidden)
                .environment(\.defaultMinListRowHeight, 64)
                .scrollContentBackground(.hidden)
                .frame(height: geo.size.height, alignment: .top)
                .scrollDismissesKeyboard(.interactively)
            }
        }
    }
}
