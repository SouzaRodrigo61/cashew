//
//  Onboarding+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension Onboarding {
    struct Feature: Reducer {
        struct Path: Reducer {
            enum State: Equatable {
                case login(Login.Feature.State = .init())
                case createCompany(CreateCompany.Feature.State = .init())
                case createTypeCompany(CreateTypeCompany.Feature.State = .init())
            }
            
            enum Action: Equatable {
                case createCompany(CreateCompany.Feature.Action)
                case createTypeCompany(CreateTypeCompany.Feature.Action)
                case login(Login.Feature.Action)
            }
            
            var body: some Reducer<State, Action> {
                Scope(state: /State.createCompany, action: /Action.createCompany) {
                    CreateCompany.Feature()
                }
                Scope(state: /State.createTypeCompany, action: /Action.createTypeCompany) {
                    CreateTypeCompany.Feature()
                }
                Scope(state: /State.login, action: /Action.login) {
                    Login.Feature()
                }
            }
        }
        
        struct State: Equatable {
            var path: StackState<Path.State>
        }
        
        enum Action: Equatable {
            case path(StackAction<Path.State, Path.Action>)
            case buttonTapped
            case goToHomeTapped
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                .forEach(\.path, action: /Action.path) {
                    Path()
                }
        }
        
        @Dependency(\.dismiss) var dismiss
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .goToHomeTapped:
                state = .new()
                return .none
            case .buttonTapped:
                state.path.append(.createCompany(.init()))
                return .none
            case .path(.popFrom(id: let id)):
                state.path.pop(from: id)
                return .none
            case .path(.push(id: _, state: _)):
                print("Pass here 2x")
                return .none
            case let .path(action):
                switch action {
                case .element(id: let id, action: .createCompany(.dismissTapped)):
                    return .send(.path(.popFrom(id: id)))
                    
                case .element(id: _, action: .createCompany(.buttonTapped)):
                    state.path.append(.createTypeCompany(.init()))
                    return .none
                    
                case .element(id: let id, action: .createTypeCompany(.dismissTapped)):
                    return .send(.path(.popFrom(id: id)))
                    
                case .element(id: _, action: .createTypeCompany(.buttonTapped)):
                    return .send(.goToHomeTapped)
                    
                default:
                    return .none
                }
            }
        }
    }
}
