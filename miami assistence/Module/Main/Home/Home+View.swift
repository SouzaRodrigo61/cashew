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
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        IfLetStore(store.scope(state: \.header, action: Feature.Action.header)) {
                            Header.View(store: $0)
                        }
                        
                        IfLetStore(store.scope(state: \.task, action: Feature.Action.task)) {
                            Task.View(store: $0)
                        }
                    }
                    
                    IfLetStore(store.scope(state: \.bottomSheet, action: Feature.Action.bottomSheet)) {
                        BottomSheet.View(store: $0)
                    }
                }
                .ignoresSafeArea(.container, edges: .bottom)
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}
