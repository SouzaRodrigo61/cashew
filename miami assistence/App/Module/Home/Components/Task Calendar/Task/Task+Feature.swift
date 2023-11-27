//
//  Task+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import Foundation
import SwiftUI

extension Task {
    struct Feature: Reducer {
        struct State: Equatable {
            var item: IdentifiedArrayOf<TaskItem.Feature.State> = []
            var isEmpty: Empty.Feature.State?
            
            var currentHour: Date = .now
        }
        
        enum Action: Equatable {
            case item(TaskItem.Feature.State.ID, TaskItem.Feature.Action)
            case isEmpty(Empty.Feature.Action)
            
            case goToDetail(Task.Model)
            case showTaskCreate
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
                .ifLet(\.isEmpty, action: /Action.isEmpty) {
                    Empty.Feature()
                }
        }
    }
}
