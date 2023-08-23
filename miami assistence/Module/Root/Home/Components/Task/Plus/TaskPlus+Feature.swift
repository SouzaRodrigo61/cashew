//
//  TaskPlus+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import ComposableArchitecture
import Foundation

extension TaskPlus {
    struct Feature: Reducer {
        struct State: Equatable {
            var progress: CGFloat
        }
        
        enum Action: Equatable {
            
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
