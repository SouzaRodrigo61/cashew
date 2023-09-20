//
//  Search+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/09/23.
//

import ComposableArchitecture

extension Search {
    struct Feature: Reducer {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
        }
        
        @Dependency(\.dismiss) var dismiss
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
