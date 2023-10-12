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
            WithViewStore(store, observe: \.task) { viewStore in
                List {
                    Section {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(viewStore.title)
                                .getContrast(backgroundColor: Color(hex: viewStore.color))
                            Text("Data: \(viewStore.date.description)")
                                .getContrast(backgroundColor: Color(hex: viewStore.color))
                            Text("Hour: \(viewStore.startedHour.description)")
                                .getContrast(backgroundColor: Color(hex: viewStore.color))
                            Text("Duration: \(viewStore.duration.description)")
                                .getContrast(backgroundColor: Color(hex: viewStore.color))
                        }
                        .padding(8)
                    }
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                    
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
                .environment(\.colorScheme, Color(hex: viewStore.color).getContrast() ? .dark : .light)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        Button {
                            store.send(.closeTapped)
                        } label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .font(.system(.body, design: .rounded, weight: .bold))
                            }
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text(viewStore.title)
                            .font(.system(.title3, design: .rounded, weight: .bold))
                    }
                }
                .toolbarColorScheme(Color(hex: viewStore.color).getContrast() ? .dark : .light, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .background(Color(hex: viewStore.color))
                .onTapGesture(count: 2) {
                    store.send(.addBlock)
                }
            }
        }
    }
}
