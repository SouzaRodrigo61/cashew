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
                EmptyView()
            } destination: {
                switch $0 {
                case .home: 
                    CaseLet(
                        /Feature.Path.State.home,
                         action: Feature.Path.Action.home,
                         then: Home.View.init(store:)
                    )
                case .login:
                    CaseLet(
                        /Feature.Path.State.home,
                         action: Feature.Path.Action.home,
                         then: Home.View.init(store:)
                    )
                case .onboarding:
                    CaseLet(
                        /Feature.Path.State.onboarding,
                         action: Feature.Path.Action.onboarding,
                         then: Onboarding.View.init(store:)
                    )
                case .createCompany:
                    CaseLet(
                        /Feature.Path.State.createCompany,
                         action: Feature.Path.Action.createCompany,
                         then: CreateCompany.View.init(store:)
                    )
                case .createTypeCompany:
                    CaseLet(
                        /Feature.Path.State.createTypeCompany,
                         action: Feature.Path.Action.createTypeCompany,
                         then: CreateTypeCompany.View.init(store:)
                    )
                }
            }
        }
    }
}
