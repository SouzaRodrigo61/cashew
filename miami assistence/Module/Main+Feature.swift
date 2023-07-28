//
//  Main+Destination.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Main {
    struct Feature: ReducerProtocol {
        struct Path: ReducerProtocol {
            enum State: Codable, Equatable, Hashable {
                
            }
            
            enum Action: Equatable {
            }
            
            var body: some ReducerProtocol<State, Action> {
                
            }
        }
        
        struct State: Equatable {
            var path: StackState<Path.State>
        }
        
        enum Action: Equatable {
            case path(StackAction<Path.State, Path.Action>)
        }
        
        var body: some ReducerProtocol<State, Action> {
            Reduce(self.core)
        }
        
        private func core(into state: inout State, action: Action) -> EffectTask<Action> {
            return .none
        }
        
    }
}
