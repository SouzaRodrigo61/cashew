//
//  Task Calendar+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 15/09/23.
//

import SwiftUI
import ComposableArchitecture

extension TaskCalendar {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            ZStack(alignment: .top) {
                
                IfLetStore(store.scope(state: \.task, action: Feature.Action.task)) {
                    Task.View(store: $0)
                }
                .offset(y: 120)
                
                IfLetStore(store.scope(state: \.header, action: Feature.Action.header)) {
                    Header.View(store: $0)
                }
            }
            .onAppear { store.send(.onAppear) }
            .overlay {
                IfLetStore(store.scope(state: \.taskCreate, action: Feature.Action.taskCreate)) {
                    TaskCreate.View(store: $0)
                }
                .background(.white)
                .transition(.move(edge: .top))
            }
        }
    }
}
