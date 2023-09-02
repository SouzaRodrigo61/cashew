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
        
        @State var offset: CGFloat = .zero

        @State private var dragId: String = ""
        
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
                }
                .coordinateSpace(name: "SCROLL")
                .accessibilityLabel("Lista de dados")
                .contentMargins(8, for: .scrollContent)
                .listRowSpacing(8)
                .scrollIndicators(.hidden)
                .environment(\.defaultMinListRowHeight, 64)
                .scrollContentBackground(.hidden)
                .overlay(alignment: .top) {
                    VStack {
                        IfLetStore(store.scope(state: \.create, action: Feature.Action.create)) {
                            TaskCreate.View(store: $0)
                        }
                    }
                    .clipShape(.rect(cornerRadius: 16))
                    .padding(.top, 4)
                    .shadow(radius: 8)
                }
                .frame(height: abs(geo.size.height - 80), alignment: .top)
                .scrollDismissesKeyboard(.interactively)
            }
        }
    }
    
}
