//
//  Main+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Main {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: \.userState) { viewStore in
                switch viewStore.state {
                case .logged:
                    IfLetStore(store.scope(state: \.home, action: Feature.Action.home)) {
                        Home.View(store: $0)
                    }
                case .logout:
                    IfLetStore(store.scope(state: \.onboarding, action: Feature.Action.onboarding)) {
                        Onboarding.View(store: $0)
                    }
                }
            }
        }
    }
}
