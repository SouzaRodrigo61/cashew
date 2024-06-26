//
//  Task+Destination.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import ComposableArchitecture

extension Home {
    @Reducer
    struct Destination {
        
        @CasePathable
        @dynamicMemberLookup
        enum State: Equatable {
            case search(Search.Feature.State)
            case settings(Settings.Feature.State)
            case note(Note.Feature.State)
        }
        
        enum Action: Equatable {
            case search(Search.Feature.Action)
            case settings(Settings.Feature.Action)
            case note(Note.Feature.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: /State.search, action: /Action.search) {
                Search.Feature()
            }
            Scope(state: /State.settings, action: /Action.settings) {
                Settings.Feature()
            }
            Scope(state: /State.note, action: /Action.note) {
                Note.Feature()
            }
        }
    }
}
