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
                    .background {
                        GeometryReader { geometry in
                            Color.clear
                                .preference(key: ScrollOffsetPreferenceKey.self,
                                            value: geometry.frame(in: .named("SCROLL")).origin)
                        }
                    }
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        if axisY.isNaN { axisY = value.y }
                        
                        if value.y != axisY {
                            store.send(.isScrolling(true), animation: .smooth)
                        } else {
                            store.send(.isScrolling(false), animation: .smooth)
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
                .frame(height: abs(geo.size.height - 100), alignment: .top)
                .scrollDismissesKeyboard(.interactively)
            }
        }
    }
}
