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
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("onboarding.text.manager")
                                .foregroundStyle(.dark)
                                .font(.largeTitle.bold())
                            Text("onboarding.text.everything")
                                .foregroundStyle(.cornFlower)
                                .font(.largeTitle.bold())
                            Text("onboarding.text.everywhere")
                                .foregroundStyle(.cornFlower)
                                .font(.largeTitle.bold())
                            Text("onboarding.text.anytime")
                                .foregroundStyle(.blush)
                                .font(.largeTitle.bold())
                        }
                        .padding(.horizontal, 16)
                        .hSpacing(.leading)
                        .padding(.bottom, 16)
                        
                        VStack {
                            Text("onboarding.text.small_text")
                                .foregroundStyle(.dark)
                        }
                        .padding(.horizontal, 16)
                        .hSpacing(.leading)
                        
                        Spacer()

                        
                        Button {
                            store.send(.goToHomeTapped, transaction: .init(animation: .bouncy))
                        } label: {
                            VStack {
                                Text("onboarding.button.get_started")
                                    .foregroundStyle(.white)
                                    .font(.body.bold())
                            }
                            .padding()
                            .hSpacing(.center)
                            .background(.dark, in: .rect(cornerRadius: 8))
                            .padding(.horizontal)
                        }
                    }
                    .background(.alabaster)
                }
                .ignoresSafeArea(.container, edges: .top)
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
