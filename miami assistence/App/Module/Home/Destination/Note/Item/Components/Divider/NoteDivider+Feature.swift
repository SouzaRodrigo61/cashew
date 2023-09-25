//
//  NoteDivider+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/09/23.
//

import Foundation
import ComposableArchitecture

extension NoteDivider {
    struct Feature: Reducer {
        struct State: Equatable {
            var content: Note.Model.Item.Block.Line
        }
        
        enum Action: Equatable {
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
