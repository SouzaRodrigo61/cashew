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
    
    @Reducer
    struct Feature {
        
        @ObservableState
        struct State: Equatable {
            var item: IdentifiedArrayOf<TaskItem.Feature.State> = []
            var isEmpty: Empty.Feature.State?
        }
        
        @CasePathable
        enum Action: Equatable {
            case item(IdentifiedActionOf<TaskItem.Feature>)
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
