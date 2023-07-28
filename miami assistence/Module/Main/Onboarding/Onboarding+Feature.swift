//
//  Onboarding+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension Onboarding {
    struct Feature: ReducerProtocol {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
            case buttonTapped
        }
        
        var body: some ReducerProtocol<State, Action> {
            Reduce(self.core)
        }
        
        private func core(into state: inout State, action: Action) -> EffectTask<Action> {
            return .none
        }
    }
}
