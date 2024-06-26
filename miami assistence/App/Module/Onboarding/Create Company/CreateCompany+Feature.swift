//
//  Create Company+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension CreateCompany {
    
    @Reducer
    struct Feature {
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
