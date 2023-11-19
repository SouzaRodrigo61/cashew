//
//  Task Calendar+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/09/23.
//

import SwiftUI
import ComposableArchitecture
import UserNotifications
import CoreData

extension TaskCalendar {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 0) {
                            
                            IfLetStore(store.scope(state: \.task, action: Feature.Action.task)) {
                                Task.View(store: $0)
                            }
                            
                            IfLetStore(store.scope(state: \.info, action: Feature.Action.info)) {
                                TaskInfo.View(store: $0)
                            }
                            
                            IfLetStore(store.scope(state: \.inspiration, action: Feature.Action.inspiration)) {
                                TaskInspiration.View(store: $0)
                            }
                        }
                        .offset(y: 140)
                        
                    } header: {
                        IfLetStore(store.scope(state: \.header, action: Feature.Action.header)) {
                            Header.View(store: $0)
                        }
                    }
                }
            }
            .ignoresSafeArea(.container, edges: .top)
            .scrollIndicators(.hidden)
            .onAppear { store.send(.onAppear) }
            .overlay {
                IfLetStore(store.scope(state: \.taskCreate, action: Feature.Action.taskCreate)) {
                    TaskCreate.View(store: $0)
                }
                .background(.white)
                .transition(.move(edge: .top))
            }
            .overlay(alignment: .bottomTrailing) {
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
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
                .padding(.trailing, 16)
            }
        }
    }
}


struct FramePreference: PreferenceKey {
    static var defaultValue: [CGRect] = []

    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}
