//
//  Task+Destination.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import ComposableArchitecture

extension Home {
    struct Destination: Reducer {
        enum State: Equatable {
            case taskDetail(TaskDetail.Feature.State = .init())
        }
        
        enum Action: Equatable {
            case taskDetail(TaskDetail.Feature.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: /State.taskDetail, action: /Action.taskDetail) {
                TaskDetail.Feature()
            }
        }
    }
}
