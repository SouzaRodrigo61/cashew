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
            case note(Note.Feature.State)
        }
        
        enum Action: Equatable {
            case note(Note.Feature.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: /State.note, action: /Action.note) {
                Note.Feature()
            }
        }
    }
}
