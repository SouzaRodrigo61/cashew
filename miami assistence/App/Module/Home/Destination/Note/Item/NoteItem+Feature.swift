//
//  NoteItem+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/09/23.
//

import ComposableArchitecture
import Foundation

extension NoteItem {
    @Reducer
    struct Feature {
        
        @ObservableState
        struct State: Equatable, Identifiable {
            var id = UUID()
            var text: NoteText.Feature.State?
            var asset: NoteAsset.Feature.State?
            var divider: NoteDivider.Feature.State?
        }
        
        @CasePathable
        enum Action: Equatable {
            case text(NoteText.Feature.Action)
            case asset(NoteAsset.Feature.Action)
            case divider(NoteDivider.Feature.Action)
        }
        
        var body: some Reducer<State, Action> {
            EmptyReducer()
                .ifLet(\.text, action: /Action.text) {
                    NoteText.Feature()
                }
                .ifLet(\.asset, action: /Action.asset) {
                    NoteAsset.Feature()
                }
                .ifLet(\.divider, action: /Action.divider) {
                    NoteDivider.Feature()
                }
        }
    }
}

