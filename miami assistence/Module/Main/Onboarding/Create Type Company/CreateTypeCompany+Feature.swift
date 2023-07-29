//
//  Create Type Company+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension CreateTypeCompany {
    struct Feature: ReducerProtocol {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
            case dismissTapped
            case buttonTapped
        }
        
        var body: some ReducerProtocol<State, Action> {
            EmptyReducer()
        }
    }
}
