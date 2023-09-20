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
            var empty: TaskEmpty.Feature.State?
        }
        
        enum Action: Equatable {
            case item(TaskItem.Feature.State.ID, TaskItem.Feature.Action)
            case empty(TaskEmpty.Feature.Action)
            
            case goToDetail(Task.Model)
            case showTaskCreate
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                .forEach(\.item, action: /Action.item) {
                    TaskItem.Feature()
                }
                .ifLet(\.empty, action: /Action.empty) {
                    TaskEmpty.Feature()
                }
        }
    }
}

// MARK: - Reduce Actions
extension Task.Feature {
    private func core(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        
        default:
            return .none
        }
    }
}
