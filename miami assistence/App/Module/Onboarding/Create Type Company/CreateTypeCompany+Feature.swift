//
//  Create Type Company+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension CreateTypeCompany {
    
    @Reducer
    struct Feature {
        
        @ObservableState
        struct State: Equatable { }
        
        @CasePathable
        enum Action: Equatable {
            case dismissTapped
            case buttonTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
