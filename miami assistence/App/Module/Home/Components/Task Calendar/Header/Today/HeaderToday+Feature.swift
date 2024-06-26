
//
//  HeaderToday+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 19/08/23.
//

import ComposableArchitecture
import Foundation

extension HeaderToday {
    @Reducer
    struct Feature {
        @ObservableState
        struct State: Equatable {
            var week: String = ""
            var weekCompleted: String = ""
        }
        
        @CasePathable
        enum Action: Equatable {
            case buttonTapped
            case changeDay(Date)
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}

