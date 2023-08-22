//
//  Task+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import Foundation
import SwiftUI

// Define the time interval for 1 hour
let oneDay: TimeInterval = 60 * 60

extension Task {
    struct Feature: Reducer {
        struct State: Equatable {
            var item: IdentifiedArrayOf<TaskItem.Feature.State> = [
                .init(task: .init(title: "Apple", date: .now, duration: 3600)),
                .init(task: .init(title: "Banana", date: .now.addingTimeInterval(-oneDay), duration: 3600)),
                .init(task: .init(title: "Cherry", date: .now.addingTimeInterval(oneDay), duration: 3600))
            ]
            
            var currentlyTask: Task.Model?
            var dragging: Bool = false
            
            var create: TaskCreate.Feature.State?
            var details: TaskDetail.Feature.State?
        }
        
        enum Action: Equatable {
            case reOrdering
            case removeDragging
            case item(TaskItem.Feature.State.ID, TaskItem.Feature.Action)
            
            case create(TaskCreate.Feature.Action)
            case details(TaskDetail.Feature.Action)
            
            case goToDetail(Task.Model)
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                .forEach(\.item, action: /Action.item) {
                    TaskItem.Feature()
                }
        }
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .reOrdering:
                return reSortingWhenNeeded(into: &state)
            case .removeDragging:
                return removeCurrentlyDragging(into: &state)
            case .item(_, .removeCurrentlyDragging):
                return removeCurrentlyTaskWhenDragging(into: &state)
            case let .item(_, .currentlyDragging(task)):
                return setCurrentlyTaskWhenDragging(into: &state, task: task)
            case let .item(_, .dragged(droppingTask)):
                return whenDraggingTaskMoveAndChangeTime(into: &state, task: droppingTask)
            case let .item(_, .sendToDetail(task)):
                return .send(.goToDetail(task))
            default:
                return .none
            }
        }
        
        // MARK: - Result from Actions
        
        private func reSortingWhenNeeded(into state: inout State) -> Effect<Action> {
            state.item.sort { $0.task.date < $1.task.date }
            
            return .none
        }
        
        
        private func removeCurrentlyDragging(into state: inout State) -> Effect<Action> {
            state.dragging = false
            
            return .none
        }
        
        private func removeCurrentlyTaskWhenDragging(into state: inout State) -> Effect<Action> {
            state.currentlyTask = nil
            state.dragging = false
            
            return .send(.reOrdering)
        }
        
        private func setCurrentlyTaskWhenDragging(into state: inout State, task: Task.Model) -> Effect<Action> {
                state.currentlyTask = task
                
                let generator = UIImpactFeedbackGenerator(style: .light)
                 generator.impactOccurred()
                
                return .none
        }
        
        private func whenDraggingTaskMoveAndChangeTime(into state: inout State, task: Task.Model) -> Effect<Action> {
            state.dragging = true
            
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
            
            guard let currentlyTask = state.currentlyTask else { return .none }
            guard let sourceIndex = state.item.firstIndex(where: { $0.task.id == currentlyTask.id }) else { return .none }
            guard let destinationIndex = state.item.firstIndex(where: { $0.task.id == task.id }) else { return .none }
            
            let sourceDestination = state.item[destinationIndex]
            let sourceItem = state.item.remove(at: sourceIndex)
            
            state.item.insert(sourceItem, at: destinationIndex)
            
            guard let tempDest = state.item.firstIndex(where: { $0.id == sourceDestination.id }) else { return .none }
            guard let tempFoward = state.item.firstIndex(where: { $0.id == sourceItem.id }) else { return .none }
            
            state.item[tempDest].task.date = sourceItem.task.date
            state.item[tempFoward].task.date = sourceDestination.task.date
            
            return .none
        }
    }
}
