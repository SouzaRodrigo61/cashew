
//
//  HeaderToday+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 19/08/23.
//

import ComposableArchitecture

extension HeaderToday {
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

