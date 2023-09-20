//
//  TaskDetails+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture

extension Note {
    struct Feature: Reducer {
        struct State: Equatable {
            var showContent: Bool = false
            
            var task: Task.Model
        }
        
        enum Action: Equatable {
            case onAppear
            case closeTapped
        }
        
        @Dependency(\.dismiss) var dismiss
        
        var body: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                case .onAppear:
                    state.showContent.toggle()
                    return .none
                case .closeTapped:
                    return .run { send in
                        await dismiss()
                    }
                }
            }
        }
    }
}
