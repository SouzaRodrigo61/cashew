//
//  Create+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 19/08/23.
//

import ComposableArchitecture

extension TaskCreate {
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
