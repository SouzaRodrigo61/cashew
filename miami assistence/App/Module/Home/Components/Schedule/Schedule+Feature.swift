//
//  Calendar+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 04/09/23.
//

import ComposableArchitecture

extension Schedule {
    @Reducer
    struct Feature {
        @ObservableState
        struct State: Equatable { }
        
        @CasePathable
        enum Action: Equatable { }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
