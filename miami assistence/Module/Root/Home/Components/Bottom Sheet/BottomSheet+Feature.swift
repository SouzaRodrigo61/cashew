//
//  BottomSheet+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import Foundation
import ComposableArchitecture

extension BottomSheet {
    struct Feature: Reducer {
        struct State: Equatable {
            var collapse = false
        }
        
        enum Action: Equatable {
            case changeHeightTapped
            case addButtonTapped
            case buttonTapped
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                ._printChanges()
        }
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .changeHeightTapped:
                state.collapse.toggle()
                
                return .none
            case .addButtonTapped:
                return .none
            case .buttonTapped:
                return .none
            }
        }
    }
}
