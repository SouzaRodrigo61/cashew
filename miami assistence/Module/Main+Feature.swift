//
//  Main+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension Main {
    enum UserState {
        case logged
        case logout
    }
    
    
    struct Feature: ReducerProtocol {
        struct State: Equatable {
            var onboarding: Onboarding.Feature.State?
            var home: Home.Feature.State?
            
            var userState: UserState = .logout
        }
        
        enum Action: Equatable {
            case home(Home.Feature.Action)
            case onboarding(Onboarding.Feature.Action)
        }
        
        var body: some ReducerProtocol<State, Action> {
            Reduce(self.core)
                .ifLet(\.onboarding, action: /Action.onboarding) {
                    Onboarding.Feature()
                }
                .ifLet(\.home, action: /Action.home) {
                    Home.Feature()
                }
        }
        
        private func core(into state: inout State, action: Action) -> EffectTask<Action> {
            switch action {
            case .onboarding(.goToHomeTapped):
                state = .init(onboarding: .new(), home: .new())
                state.userState = .logged
                return .none
            case .home(.buttonTapped):
                state = .init(onboarding: .new(), home: .new())
                state.userState = .logout
                return .none
            default:
                return .none
            }
        }
        
    }
}
