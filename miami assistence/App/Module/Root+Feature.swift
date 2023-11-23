//
//  Main+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension Root {
    struct Feature: Reducer {
        enum State: Equatable {
            case home(Home.Feature.State)
            case onboarding(Onboarding.Feature.State)
        }
        
        enum Action: Equatable {
            case home(Home.Feature.Action)
            case onboarding(Onboarding.Feature.Action)
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                .ifCaseLet(/State.onboarding, action: /Action.onboarding) {
                    Onboarding.Feature()
                }
                .ifCaseLet(/State.home, action: /Action.home) {
                    Home.Feature()
                }
        }
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .onboarding(.goToHomeTapped):
                state = .home(.new())
                return .none
            default:
                return .none
            }
        }
        
    }
}
