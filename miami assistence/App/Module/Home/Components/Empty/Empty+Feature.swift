//
//  TaskEmpty+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 03/09/23.
//

import ComposableArchitecture
import Foundation

extension Empty {
    struct Feature: Reducer {
        struct State: Equatable {
            var currentDate: Date
            var showButton: Bool = true
        }
        
        enum Action: Equatable {
            case buttonTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
