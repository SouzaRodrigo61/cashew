//
//  Create Type Company+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension CreateTypeCompany {
    struct Feature: Reducer {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
            case dismissTapped
            case buttonTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
