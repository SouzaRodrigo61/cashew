//
//  TaskInfo+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 12/11/23.
//

import ComposableArchitecture
import Foundation

extension TaskInfo {
    struct Feature: Reducer {
        struct State: Equatable { }
        
        enum Action: Equatable { }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
