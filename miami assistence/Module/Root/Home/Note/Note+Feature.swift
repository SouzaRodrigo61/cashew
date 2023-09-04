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
            var task: Task.Model?
        }
        
        enum Action: Equatable {
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
