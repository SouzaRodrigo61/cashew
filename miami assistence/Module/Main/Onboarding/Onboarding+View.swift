//
//  Onboarding+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Onboarding {
    
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            NavigationStackStore(store.scope(state: \.path, action: Feature.Action.path)) {
                VStack {
                    Text(
                          """
                          This screen demonstrates a basic feature hosted in a navigation stack.
                          
                          You can also have the child feature dismiss itself, which will communicate back to the \
                          root stack view to pop the feature off the stack.
                          """
                    )
                    .padding(.horizontal)
                    Button("Go to Home") {
                        store.send(.goToHomeTapped, transaction: .init(animation: .bouncy))
                    }
                    
                    Spacer()
                    
                    Button {
                        store.send(.buttonTapped, animation: .snappy(duration: 2))
                    } label : {
                        HStack {
                            Image(systemName: "star")
                            Text("Star system name")
                        }
                    }
                    .foregroundStyle(.miamiWhite)
                    .padding()
                    .background(.miamiDarkGraySecond, in: .rect(cornerRadius: 16))
                    
                }
                .toolbar(.hidden, for: .navigationBar)
            } destination: {
                switch $0 {
                case .login:
                    CaseLet(
                        /Feature.Path.State.login,
                         action: Feature.Path.Action.login,
                         then: Login.View.init(store:)
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
