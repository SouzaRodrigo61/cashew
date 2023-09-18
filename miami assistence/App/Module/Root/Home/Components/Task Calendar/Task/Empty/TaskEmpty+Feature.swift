//
//  TaskEmpty+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 03/09/23.
//

import ComposableArchitecture
import Foundation

extension TaskEmpty {
    struct Feature: Reducer {
        struct State: Equatable {
            var currentDate: Date
        }
        
        enum Action: Equatable {
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
