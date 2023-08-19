//
//  Header+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture

extension Header {
    struct Feature: Reducer {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
            case todayTapped
            case searchTapped
            case moreTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
