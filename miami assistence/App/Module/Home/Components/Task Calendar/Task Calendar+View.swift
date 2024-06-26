//
//  Task Calendar+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/09/23.
//

import SwiftUI
import ComposableArchitecture
import UserNotifications

extension TaskCalendar {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            GeometryReader {
                let safeArea = $0.safeAreaInsets
                
                Home(safeArea)
                    .ignoresSafeArea(.container, edges: .top)
            }
            .onAppear { store.send(.onAppear) }
            .overlay(alignment: .bottomTrailing) {
                WithViewStore(store, observe: \.taskCreate) { viewStore in
                    if viewStore.state == nil {
                        Button {
                            store.send(.showTaskCreate, animation: .bouncy)
                        } label: {
                            Image(systemName: "plus")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(width: 36, height: 36)
                                .background(.dark, in: .rect(cornerRadius: 8))
                                .padding(2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.cute500, lineWidth: 2)
                                )
                        }
                        .padding(.trailing, 16)
                    } else {
                        IfLetStore(store.scope(state: \.taskCreate, action: \.taskCreate)) {
                            TaskCreate.View(store: $0)
                        }
                        .background(.white)
                        .transition(
                            .opacity
                            .combined(with: .move(edge: .bottom))
                            .combined(with: .scale)
                            .combined(with: .move(edge: .trailing))
                        )
                    }
                }
            }
        }
        
        
        // MARK: - Home ViewBuilder
        @ViewBuilder
        func Home(_ safeArea: EdgeInsets) -> some SwiftUI.View {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    IfLetStore(store.scope(state: \.header, action: \.header)) {
                        Header.View(store: $0, safeArea: safeArea)
                    }
                    
                    VStack(spacing: 0) {
                        IfLetStore(store.scope(state: \.task, action: \.task)) {
                            Task.View(store: $0)
                        }

                        IfLetStore(store.scope(state: \.info, action: \.info)) {
                            TaskInfo.View(store: $0)
                        }

                        IfLetStore(store.scope(state: \.inspiration, action: \.inspiration)) {
                            TaskInspiration.View(store: $0)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(CustomScrollBehavior(maxHeight: 16))
        }
    }
}
