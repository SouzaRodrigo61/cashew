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
            
            // TODO: Migrate Datas for .mock and .live
            var tasks: [Model] = [
                .init(title: "Apple"),
                .init(title: "Banana"),
                .init(title: "Cherry"),
                .init(title: "Date"),
                .init(title: "Fig"),
                .init(title: "Grape"),
                .init(title: "Kiwi"),
                .init(title: "Orange")
            ]
            var currentlyDragging: Model?
            var draggingEffect = false
            
            // TODO: Migrate to Corrently Model
            struct Model: Identifiable, Equatable {
                var id = UUID()
                var title: String
            }
        }
        
        enum Action: Equatable {
            case tasks
            case currentlyDragging(State.Model)
            case removeCurrentlyDragging
            case dragged(State.Model)
        }
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
        }
        
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .tasks:
                return .none
            case .removeCurrentlyDragging:
                state.draggingEffect = false
                state.currentlyDragging = nil
                
                return .none
            case let .currentlyDragging(task):
                state.currentlyDragging = task
                
                return .none
            case let .dragged(droppingTask):
                state.draggingEffect = true
                
                if let currentlyDragging = state.currentlyDragging {
                    if let sourceIndex = state.tasks.firstIndex(where: { $0.id == currentlyDragging.id }),
                       let destinationIndex = state.tasks.firstIndex(where: { $0.id == droppingTask.id}) {
                        let sourceItem = state.tasks.remove(at: sourceIndex)
                        
                        state.tasks.insert(sourceItem, at: destinationIndex)
                    }

                }
                
                return .none
            }
        }
    }
}
