//
//  Home+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

extension Home {
    struct Feature: Reducer {
        struct State: Equatable {
            var task: Task.Feature.State?
            var header: Header.Feature.State?
            var bottomSheet: BottomSheet.Feature.State?
            
            var destination: StackState<Destination.State>
        }
        
        enum Action: Equatable {
            case task(Task.Feature.Action)
            case header(Header.Feature.Action)
            case bottomSheet(BottomSheet.Feature.Action)
            
            case buttonTapped
            
            case destination(StackAction<Destination.State, Destination.Action>)
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
                .forEach(\.destination, action: /Action.destination) {
                    Destination()
                }
        }
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case let .task(.goToDetail(task)):
                state.destination.append(.taskDetail(.init(task: task)))
                return .none
            case .bottomSheet(.addButtonTapped):
                state.task?.create = .init()
                state.bottomSheet?.collapse = false
                
                guard state.header != nil else { return .none }                
                state.header?.isScroll = false
                
                return .none
            case .task(.showTaskCreate):
                state.bottomSheet?.collapse = false
                
                return .none
            case let .task(.isScrolling(value)):
                guard state.header != nil else { return .none }
                
                state.header?.isScroll = value
                
                return .none
            default:
                return .none
            }
        }
    }
}
