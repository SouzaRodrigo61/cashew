//
//  NoteText+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/09/23.
//

import Foundation
import ComposableArchitecture

extension NoteText {
    struct Feature: Reducer {
        struct State: Equatable, Identifiable {
            var id = UUID()
            var content: Note.Model.Item.Block.Text
        }
        
        enum Action: Equatable, Sendable {
            case changeText(String)
            case updatedContent(Note.Model.Item.Block.Text)
        }
        
        var body: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                case .changeText(let newText):
                    state.content.text = newText
                    return .send(.updatedContent(state.content))
                default:
                    return .none
                }
            }
        }
    }
}
