//
//  TaskItem+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import Foundation

extension TaskItem {
    struct Feature: Reducer {
        struct State: Equatable, Identifiable {
            var id = UUID()
            var task: Task.Model
            
            var draggingTaskId: UUID?
            var isDragging: Bool = false
        }
        
        enum Action: Equatable {
            case currentlyDragging(Task.Model)
            case removeCurrentlyDragging
            case dragged(Task.Model)
            case sendToDetail(Task.Model)
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
