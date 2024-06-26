//
//  NoteText+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/09/23.
//

import Foundation
import ComposableArchitecture

extension NoteText {
    @Reducer
    struct Feature {
        
        @ObservableState
        struct State: Equatable, Identifiable {
            var id = UUID()
            var content: Note.Model.Item.Block.Text
            var hasFocus: Bool = true
        }
        
        enum Action: Equatable, Sendable {
            case changeFocus(Bool)
            case changeText(String)
            case updatedContent(Note.Model.Item.Block.Text)
            case nextLine
            case removeLine
            case delegate(Delegate)
            
            enum Delegate: Equatable, Sendable {
                case shouldReturn(String)
            }
        }
        
        var body: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                case .changeFocus(let focus):
                    state.hasFocus = focus
                    
                    return .none
                case .changeText(let newText):
                    state.content.text = newText
                    
                    return .send(.updatedContent(state.content))
                case .delegate(.shouldReturn(let text)):
                    if text.isEmpty {
                        return .send(.removeLine)
                    }
                    
                    return .send(.nextLine)
                default:
                    return .none
                }
            }
        }
    }
}
