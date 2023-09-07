//
//  Home+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import SwiftUI
import ComposableArchitecture

extension Home {
    struct Feature: Reducer {
        struct State: Equatable {
            var task: Task.Feature.State?
            var header: Header.Feature.State?
            var bottomSheet: BottomSheet.Feature.State?
            
            var destination: StackState<Destination.State>
            
            var taskCreate: TaskCreate.Feature.State?
            @PresentationState var schedule: Schedule.Feature.State?
            
            var contentTask: Task.Model?
            var forcePadding: Bool = false
        }
        
        enum Action: Equatable {
            
            // Components
            case task(Task.Feature.Action)
            case header(Header.Feature.Action)
            case bottomSheet(BottomSheet.Feature.Action)
            case taskCreate(TaskCreate.Feature.Action)
            
            // Handle
            case buttonTapped
            
            case matcheAnimationRemoved
            
            // Stacks
            case destination(StackAction<Destination.State, Destination.Action>)
            
            case schedule(PresentationAction<Schedule.Feature.Action>)
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                .ifLet(\.task, action: /Action.task) {
                    Task.Feature()
                }
                .ifLet(\.header, action: /Action.header) {
                    Header.Feature()
                }
                .ifLet(\.bottomSheet, action: /Action.bottomSheet) {
                    BottomSheet.Feature()
                }
                .ifLet(\.taskCreate, action: /Action.taskCreate) {
                    TaskCreate.Feature()
                }
                .ifLet(\.$schedule, action: /Action.schedule) {
                    Schedule.Feature()
                }
                .forEach(\.destination, action: /Action.destination) {
                    Destination()
                }
        }
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .bottomSheet(.addButtonTapped):
                state.taskCreate = .init()
                
                state.bottomSheet?.collapse = false
                
                guard state.header != nil else { return .none }
                state.header?.isScroll = false
                
                return .none
            case .task(.showTaskCreate):
                state.taskCreate = .init()
                
                state.bottomSheet?.collapse = false
                
                guard state.header != nil else { return .none }
                state.header?.isScroll = false
                
                return .none
            case .taskCreate(.createTaskTapped):
                guard let content = state.taskCreate else { return .none }
                
                guard state.task != nil else { return .none }
                guard let count = state.task?.item.count else { return .none }
                state.task?.empty = nil
                
                state.task?.item.append(.init(task: .init(title: content.title, date: content.date, startedHour: content.startedHour, duration: content.activityDuration, color: content.color, isAlert: false, isRepeted: false, position: (count + 1), createdAt: .now, updatedAt: .now, tag: [], note: [])))
                
                state.taskCreate = nil
                
                return .none
            case .taskCreate(.closeTapped):
                state.taskCreate = nil
                
                guard state.header != nil else { return .none }
                state.header?.isScroll = false
                
                return .none
            case let .task(.item(_, .contentTapped(task))):
                state.destination.append(.note(.init(task: task)))
                state.contentTask = task
                
                return .none
                
            case .header(.today(.buttonTapped)):
                state.schedule = .init()
                
                return .none
                
            case .destination(.element(id: _, action: .note(.closeTapped))):
                state.forcePadding = true
                return .run { send in
                    try! await SwiftUI.Task.sleep(for: .seconds(0.04))
                    await send(.matcheAnimationRemoved, animation: .smooth)
                }
                
            case .matcheAnimationRemoved:
                state.forcePadding = false
                state.contentTask = nil
                
                return .none
            default:
                return .none
            }
        }
    }
}
