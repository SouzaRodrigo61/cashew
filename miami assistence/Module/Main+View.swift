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
            NavigationStackStore(self.store.scope(state: \.path, action: Feature.Action.path)) {
                Onboarding.View(path: store)
            } destination: {
                switch $0 {
                case .home:
                    Home.builder(with: store)
                case .login:
                    Login.builder(with: store)
                }
            }
        }
    }
}
