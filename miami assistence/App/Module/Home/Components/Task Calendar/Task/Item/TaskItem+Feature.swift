//
//  TaskItem+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import Foundation

extension TaskItem {
    
    @Reducer
    struct Feature {
        
        @ObservableState
        struct State: Equatable, Identifiable {
            var id = UUID()
            var task: Task.Model
            
            var draggingTaskId: UUID?
            var isDragging: Bool = false
            
            var minY: CGFloat = 0
            var maxY: CGFloat = 0
            
            var isSelected: Bool = false
        }
        
        @CasePathable
        enum Action: Equatable {
            case setCurrentlyDragged(Task.Model)
            case moveCurrentlyDragged(Int, Int)
            
            case contentTapped(Task.Model)
            
            case deleteTask(Task.Model)
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
        }
    }
}
