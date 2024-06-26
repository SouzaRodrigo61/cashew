//
//  Login+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/07/23.
//

import ComposableArchitecture

extension Login {
    @Reducer
    struct Feature {
        
        @ObservableState
        struct State: Equatable { }
        
        @CasePathable
        enum Action: Equatable {
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
