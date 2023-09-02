//
//  Home+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Home {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            NavigationStackStore(store.scope(state: \.destination, action: Feature.Action.destination)) {
                
                VStack(spacing: 0) {
                    IfLetStore(store.scope(state: \.header, action: Feature.Action.header)) {
                        Header.View(store: $0)
                    }
                    
                    IfLetStore(store.scope(state: \.task, action: Feature.Action.task)) {
                        Task.View(store: $0)
                    }
                }
                .overlay(alignment: .bottom) {
                    IfLetStore(store.scope(state: \.bottomSheet, action: Feature.Action.bottomSheet)) {
                        BottomSheet.View(store: $0)
                    }
                }
                .ignoresSafeArea([.container, .keyboard], edges: .bottom)
                .toolbar(.hidden, for: .navigationBar)
                
            } destination: {
                switch $0 {
                case .taskDetail:
                    CaseLet(
                        /Destination.State.taskDetail,
                         action: Destination.Action.taskDetail,
                         then: TaskDetail.View.init(store:)
                    )
                }
            }
            
        }
    }
}
