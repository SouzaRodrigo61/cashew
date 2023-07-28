//
//  Main+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension Main {
    struct Feature: ReducerProtocol {
        struct Path: ReducerProtocol {
            enum State: Equatable {
                case onboarding(Onboarding.Feature.State = .init())
                case login(Login.Feature.State = .init())
                case home(Home.Feature.State = .init())
                case createCompany(CreateCompany.Feature.State = .init())
                case createTypeCompany(CreateTypeCompany.Feature.State = .init())
            }
            
            enum Action: Equatable {
                case createCompany(CreateCompany.Feature.Action)
                case createTypeCompany(CreateTypeCompany.Feature.Action)
                case home(Home.Feature.Action)
                case login(Login.Feature.Action)
                case onboarding(Onboarding.Feature.Action)
            }
            
            var body: some ReducerProtocol<State, Action> {
                Scope(state: /State.createCompany, action: /Action.createCompany) {
                    CreateCompany.Feature()
                }
                Scope(state: /State.createTypeCompany, action: /Action.createTypeCompany) {
                    CreateTypeCompany.Feature()
                }
                Scope(state: /State.onboarding, action: /Action.onboarding) {
                    Onboarding.Feature()
                }
                Scope(state: /State.login, action: /Action.login) {
                    Login.Feature()
                }
                Scope(state: /State.home, action: /Action.home) {
                    Home.Feature()
                }
            }
        }
        
        struct State: Equatable {
            var path: StackState<Path.State>
        }
        
        enum Action: Equatable {
            case path(StackAction<Path.State, Path.Action>)
        }
        
        var body: some ReducerProtocol<State, Action> {
            Reduce(self.core)
        }
        
        private func core(into state: inout State, action: Action) -> EffectTask<Action> {
            switch action {
            case .path(.element(id: _, action: .onboarding(.buttonTapped))):
//                tracking("action", "state")
                state.path.append(.createCompany(.init()))
                return .none
            case .path(.popFrom(id: let id)):
                state.path.pop(from: id)
                return .none
            case .path(.push(id: _, state: _)):
                print("Pass here 2x")
                return .none
            }
        }
        
    }
}
