//
//  Home+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension Home {
    struct Feature: Reducer {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
            case buttonTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
