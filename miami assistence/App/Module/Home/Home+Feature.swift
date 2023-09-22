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
            var taskCalendar: TaskCalendar.Feature.State
            
            var destination: StackState<Destination.State>
            @PresentationState var schedule: Schedule.Feature.State?

        }
        
        enum Action: Equatable {
            /// Components Stores
            case taskCalendar(TaskCalendar.Feature.Action)
            
            /// Navigation Stores
            case destination(StackAction<Destination.State, Destination.Action>)
            case schedule(PresentationAction<Schedule.Feature.Action>)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: \.taskCalendar, action: /Action.taskCalendar) {
                TaskCalendar.Feature()
            }
            
            Reduce(self.core)
            Reduce(self.destination)
                .ifLet(\.$schedule, action: /Action.schedule) {
                    Schedule.Feature()
                }
                .forEach(\.destination, action: /Action.destination) {
                    Destination()
                }
        }
        
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
                
            case .taskCalendar(.task(.item(_, .contentTapped(let task)))):
                state.destination.append(.note(.init(task: task)))
                state.taskCalendar.contentTask = task
                
                return .none
             
            case .taskCalendar(.header(.today(.buttonTapped))):
                state.schedule = .init()

                return .none

            case .taskCalendar(.header(.moreTapped)):
                state.destination.append(.settings(.init()))

                return .none

            case .taskCalendar(.header(.searchTapped)):
                state.destination.append(.search(.init()))

                return .none
                
            default:
                return .none
            }
        }
        
        private func destination(into state: inout State, action: Action) -> Effect<Action>  {
            switch action {
            case .destination(.element(id: _, action: .note(.closeTapped))):
                state.taskCalendar.forcePadding = true
                return .run { send in
                    try! await SwiftUI.Task.sleep(for: .seconds(0.04))
                    await send(.taskCalendar(.matcheAnimationRemoved), animation: .smooth)
                }
            default:
                return .none
            }
        }
    }
}
