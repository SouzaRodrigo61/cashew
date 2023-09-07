//
//  Main+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Root {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            SwitchStore(store) {
                switch $0 {
                case .home:
                    CaseLet(/Feature.State.home, action: Feature.Action.home) { store in
                        Home.View(store: store)
                    }
                case .onboarding:
                    CaseLet(/Feature.State.onboarding, action: Feature.Action.onboarding) { store in
                        Onboarding.View(store: store)
                    }
                }
            }
        }
    }
}
