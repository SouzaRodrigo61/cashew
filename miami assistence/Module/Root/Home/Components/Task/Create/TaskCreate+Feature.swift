//
//  TaskPlus+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import ComposableArchitecture
import Foundation

extension TaskCreate {
    struct Feature: Reducer {
        struct State: Equatable {
            @BindingState var title: String = ""
        }
        
        enum Action: BindableAction, Equatable, Sendable {
            case binding(BindingAction<State>)
            case createTaskTapped
            case closeTapped
        }
        
        
        @Dependency(\.dismiss) var dismiss
        
        var body: some Reducer<State, Action> {
            BindingReducer()
            Reduce { state, action in
                switch action {
                case .closeTapped:
                    return .run { _ in await self.dismiss() }
                case .createTaskTapped:
                    return .run { _ in await self.dismiss() }
                case .binding(_):
                    return .none
                }
            }
        }
    }
}
