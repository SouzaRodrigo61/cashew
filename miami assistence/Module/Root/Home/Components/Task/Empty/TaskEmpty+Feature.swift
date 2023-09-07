//
//  TaskEmpty+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 03/09/23.
//

import ComposableArchitecture

extension TaskEmpty {
    struct Feature: Reducer {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
