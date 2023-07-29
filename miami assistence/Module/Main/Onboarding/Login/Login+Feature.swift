//
//  Login+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/07/23.
//

import ComposableArchitecture

extension Login {
    struct Feature: ReducerProtocol {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
        }
        
        var body: some ReducerProtocol<State, Action> {
            EmptyReducer()
        }
    }
}
