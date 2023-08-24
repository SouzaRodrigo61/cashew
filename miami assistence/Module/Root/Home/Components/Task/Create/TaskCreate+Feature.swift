//
//  TaskPlus+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import ComposableArchitecture
import Foundation

extension TaskCreate {
    struct Feature: Reducer {
        struct State: Equatable {
        }
        
        enum Action: Equatable {
            
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
