//
//  NoteDivider+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/09/23.
//

import Foundation
import ComposableArchitecture

extension NoteDivider {
    @Reducer
    struct Feature {
        
        @ObservableState
        struct State: Equatable {
            var content: Note.Model.Item.Block.Line
        }
        
        @CasePathable
        enum Action: Equatable { }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
