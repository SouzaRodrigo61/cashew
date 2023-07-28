//
//  Create Company+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension CreateCompany {
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
