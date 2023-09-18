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
            
        }
        
        @Dependency(\.userDefaults) var userDefaults
        
        enum Action: Equatable {
            case shortcutItem(UIApplicationShortcutItem)
            case didFinishLaunching
//            case didRegisterForRemoteNotifications(TaskResult<Data>)
//            case configurationForConnecting(UIApplicationShortcutItem?)
            case delegate(Delegate)

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
                return .run { @MainActor send in
                    send(.delegate(.didFinishLaunching))
                }
                
            case .shortcutItem(let type):
                dump(type, name: "Type - shortcutItem")
                
                return .none
            case .delegate(.didFinishLaunching):
                return .none
            }
        }
    }
}
