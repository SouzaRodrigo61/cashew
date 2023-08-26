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
            var item: IdentifiedArrayOf<TaskItem.Feature.State> = []
            
            var create: TaskCreate.Feature.State?
            var plus: TaskPlus.Feature.State?
            
            var refreshScrollView: Refreshable.Feature.State = .init(refreshHeight: 40)
        }
        
        enum Action: Equatable {
            case reOrdering
            case removeDragging
            case item(TaskItem.Feature.State.ID, TaskItem.Feature.Action)
            
            case create(TaskCreate.Feature.Action)
            case plus(TaskPlus.Feature.Action)
            
            case refreshScrollView(Refreshable.Feature.Action)
            
            case goToDetail(Task.Model)
            case showTaskCreate
            
            case dropDestinationOutScreen([String])
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                .forEach(\.item, action: /Action.item) {
                    TaskItem.Feature()
                }
                .ifLet(\.create, action: /Action.create) {
                    TaskCreate.Feature()
                }
                .ifLet(\.plus, action: /Action.plus) {
                    TaskPlus.Feature()
                }
        }
        
    }
}

// MARK: - Reduce Actions
extension Task.Feature {
    private func core(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .reOrdering:
            return reSortingWhenNeeded(into: &state)
        case .removeDragging:
            return removeCurrentlyDragging(into: &state)
            
        case .item(_, .removeCurrentlyDragging):
            return removeCurrentlyTaskWhenDragging(into: &state)
        case .item(_, .removeDragging):
            return removeCurrentlyDragged(into: &state)
        case let .item(_, .currentlyDragging(task)):
            return setCurrentlyTaskWhenDragging(into: &state, task: task)
        case let .item(_, .dragged(droppingTask)):
            return whenDraggingTaskMoveAndChangeTime(into: &state, task: droppingTask)

        case let .refreshScrollView(.progressSetted(progress)):
            return refreshScrollViewProgressSetted(into: &state, progress)
        case let .refreshScrollView(.contentOffsetGetted(progress)):
            return refreshScrollViewContentOffsetGetted(into: &state, progress)
        case .refreshScrollView(.scrollViewWillBeginDecelerating):
            return refreshScrollViewScrollViewWillBeginDecelerating(into: &state)
        case .refreshScrollView(.scrollViewWillBeginDragging):
            return refreshScrollViewScrollViewWillBeginDragging(into: &state)
        case .refreshScrollView(.refreshActived):
            return refreshScrollViewRefreshActived(into: &state)
        case let .refreshScrollView(.scrollOffset(offset)):
            state.refreshScrollView.scrollOffset = offset
            return .none
        
        case .showTaskCreate:
            state.create = .init()
            return .none
            
        case let .item(_, .sendToDetail(task)):
            return .send(.goToDetail(task))
            
        case .create(.createTask):
            state.item.append(.init(task: .init(title: UUID().uuidString, date: .now, duration: 3600, isAlert: true, isRepeted: false, createdAt: .now, updatedAt: .now, tag: [], note: [])))
            state.create = nil
            
            return .none
            
        case let .dropDestinationOutScreen(items):
            let droppedId = state.item
                .map { contain in
                    items.filter { UUID(uuidString: $0) == contain.task.id }
                }
                .first(where: { !$0.isEmpty})
                
            guard let dropped = droppedId else { return .none }
            
            dropped.forEach { value in
                if let index = state.item.firstIndex(where: { UUID(uuidString: value) == $0.task.id }) {
                    state.item[index].isDragging = false
                    state.item[index].draggingTaskId = nil
                }
            }
            
            return .none
        default:
            return .none
        }
    }
}


// MARK: - Drag and Drop item on the List
extension Task.Feature {
    
    private func reSortingWhenNeeded(into state: inout State) -> Effect<Action> {
        return .none
    }
    
    private func removeCurrentlyDragged(into state: inout State) -> Effect<Action> {
        guard let sourceIndex = state.item.firstIndex(where: { $0.draggingTaskId != nil }) else { return .none }
        state.item[sourceIndex].isDragging = false
        
        return .none
    }

    
    private func removeCurrentlyDragging(into state: inout State) -> Effect<Action> {
        guard let sourceIndex = state.item.firstIndex(where: { $0.draggingTaskId != nil }) else { return .none }
        state.item[sourceIndex].isDragging = false
        state.item[sourceIndex].draggingTaskId = nil
        
        return .none
    }
    
    private func removeCurrentlyTaskWhenDragging(into state: inout State) -> Effect<Action> {
        guard let sourceIndex = state.item.firstIndex(where: { $0.draggingTaskId != nil }) else { return .none }
        state.item[sourceIndex].isDragging = false
        state.item[sourceIndex].draggingTaskId = nil
        
        return .none
    }
    
    private func setCurrentlyTaskWhenDragging(into state: inout State, task: Task.Model) -> Effect<Action> {
        guard let sourceIndex = state.item.firstIndex(where: { $0.task.id == task.id }) else { return .none }
        state.item[sourceIndex].draggingTaskId = task.id
        state.item[sourceIndex].isDragging = false
        
        return .none
    }
    
    private func whenDraggingTaskMoveAndChangeTime(into state: inout State, task: Task.Model) -> Effect<Action> {

        UIImpactFeedbackGenerator.feedback(.soft)
        
        guard let currentlyTask = state.item.first(where: { $0.draggingTaskId != nil }) else { return .none }
        guard let sourceIndex = state.item.firstIndex(where: { $0.task.id == currentlyTask.task.id }) else { return .none }
        guard let destinationIndex = state.item.firstIndex(where: { $0.task.id == task.id }) else { return .none }
        
        state.item[sourceIndex].isDragging = true
        state.item[sourceIndex].draggingTaskId = currentlyTask.task.id
        
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


// MARK: - Refreshable ScrollView
extension Task.Feature {
    
    private func refreshScrollViewProgressSetted(into state: inout State, _ progress: CGFloat) -> Effect<Action> {
        return .none
    }
    
    private func refreshScrollViewContentOffsetGetted(into state: inout State, _ progress: CGFloat) -> Effect<Action> {
        
        var valueProgress = (progress / state.refreshScrollView.refreshHeight)
        
        valueProgress = (valueProgress < 0 ? 0 : valueProgress)
        valueProgress = (valueProgress > 1 ? 1 : valueProgress)
        
        state.refreshScrollView.contentOffset = progress
        state.refreshScrollView.progress = valueProgress
        
        guard state.plus != nil, state.plus?.progress != nil else { return .none }
        state.plus?.progress = valueProgress
        
        return .none
    }
    
    private func refreshScrollViewScrollViewWillBeginDecelerating(into state: inout State) -> Effect<Action> {
        
        state.refreshScrollView.isScroll = false
        state.refreshScrollView.isRefreshing = false
        
        guard state.create == nil else {
            return .send(.refreshScrollView(.refreshActived), animation: .smooth)
        }
                
        guard state.refreshScrollView.progress > 0.75 else {
            return .send(.refreshScrollView(.refreshActived), animation: .smooth)
        }
        
        state.refreshScrollView.isRefreshing = true

        if state.refreshScrollView.contentOffset > state.refreshScrollView.refreshHeight {
            state.refreshScrollView.contentOffset = state.refreshScrollView.refreshHeight
        }
        
        state.refreshScrollView.progress = 1
        
        guard state.plus != nil else { return .none }
        state.plus?.progress = 1
        
        UIImpactFeedbackGenerator.feedback(.heavy)

        return .run(priority: .userInitiated) { send in
            try await SwiftUI.Task.sleep(nanoseconds: 1_000_000_000)
            await send(.refreshScrollView(.refreshActived), animation: .smooth)
            await send(.showTaskCreate, animation: .spring)
        }
        
        
    }
    
    private func refreshScrollViewScrollViewWillBeginDragging(into state: inout State) -> Effect<Action> {
        state.refreshScrollView.isScroll = true
        
        if state.create == nil {
            state.plus = .init(progress: 0.0)
        }
        
        state.refreshScrollView.contentOffset = 0.0
        state.refreshScrollView.scrollOffset = 0.0
        state.refreshScrollView.progress = 0.0
        
        // TODO: Remove this action when solve bug on drag and drop
        return .send(.reOrdering, animation: .smooth)
    }
    
    private func refreshScrollViewRefreshActived(into state: inout State) -> Effect<Action> {
        state.refreshScrollView.isRefreshing = false
        state.refreshScrollView.isScroll = false
        state.refreshScrollView.contentOffset = 0.0
        state.refreshScrollView.scrollOffset = 0.0
        state.refreshScrollView.progress = 0.0
        state.plus = nil
        
        return .none
    }
}
