//
//  CoreApp+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 17/09/23.
//

import UIKit
import ComposableArchitecture

extension CoreApp {
    struct Feature: Reducer {
        struct State: Equatable {
            var config: Manager.FirestoreClient.Config?
        }
        
        @Dependency(\.userDefaults) var userDefaults
        @Dependency(\.firebaseCore) var firebaseCore
        @Dependency(\.firebaseFiretore) var firestore
        
        enum Action: Equatable {
            case shortcutItem(UIApplicationShortcutItem)
            case didFinishLaunching
            case delegate(Delegate)
            case configResponse(TaskResult<Manager.FirestoreClient.Config>)
            
            public enum Delegate: Equatable {
                case didFinishLaunching
            }
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
        }
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .didFinishLaunching:
                firebaseCore.configure()
                
                return .run { @MainActor send in
                    send(.delegate(.didFinishLaunching))
                }
                
            case .shortcutItem(let type):
                dump(type, name: "Type - shortcutItem")
                
                return .none
            case .delegate(.didFinishLaunching):
                enum Cancel { case id }
                return .run { send in
                    for try await config in try await firestore.config() {
                        await send(.configResponse(.success(config)), animation: .default)
                    }
                } catch: { error, send in
                    await send(.configResponse(.failure(error)), animation: .default)
                }
                .cancellable(id: Cancel.id)
                
            case .configResponse(.success(let config)):
                state.config = config
                
                return .none
            case .configResponse(.failure(let configError)):
                // TODO: Show error page
                dump(configError, name: "configError")
                
                return .none
            }
        }
    }
}
