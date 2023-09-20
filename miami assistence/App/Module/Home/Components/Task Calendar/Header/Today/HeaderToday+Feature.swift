
//
//  HeaderToday+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 19/08/23.
//

import ComposableArchitecture
import Foundation

extension HeaderToday {
    struct Feature: Reducer {
        struct State: Equatable {
            var week: String = ""
            var weekCompleted: String = ""
        }
        
        enum Action: Equatable {
            case buttonTapped
            
            case changeDay(Date)
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
        }
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .changeDay(let day):
                state.week = day.validateIsToday()
                state.weekCompleted = day.week()
                
                return .none
                
            default:
                return .none
            }
        }
    }
}

