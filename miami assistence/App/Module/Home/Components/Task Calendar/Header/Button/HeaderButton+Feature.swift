//
//  HeaderButton+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 11/11/23.
//

import ComposableArchitecture
import Foundation

extension HeaderButton {
    struct Feature: Reducer {
        struct State: Equatable { }
        
        enum Action: Equatable {
            case buttonTapped
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
