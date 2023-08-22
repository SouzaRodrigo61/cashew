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
            var today: HeaderToday.Feature.State?
        }
        
        enum Action: Equatable {
            case today(HeaderToday.Feature.Action)
            case searchTapped
            case moreTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
                .ifLet(\.today, action: /Action.today) {
                    HeaderToday.Feature()
                }
        }
    }
}
