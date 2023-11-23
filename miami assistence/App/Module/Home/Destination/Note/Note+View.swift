//
//  TaskDetails+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import SwiftUI

extension Note {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: \.note) { viewStore in
                List {
                    
                    Section {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEachStore(store.scope(state: \.item, action: Feature.Action.item)) {
                                NoteItem.View(store: $0)
                            }
                        }
                        .padding(8)
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
                }
                .scrollDismissesKeyboard(.immediately)
                .coordinateSpace(name: "FORMSCROLL")
                .accessibilityLabel("")
                .contentMargins(12, for: .scrollContent)
                .listRowSpacing(0)
                .listSectionSpacing(4)
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .listSectionSeparator(.hidden)
                .background(.regularMaterial, in: .rect(cornerRadius: 12))
                .padding(8)
                .toolbarBackground(.visible, for: .navigationBar)
                .onTapGesture(count: 2) {
                    store.send(.addBlock)
                }
            }
        }
    }
}
