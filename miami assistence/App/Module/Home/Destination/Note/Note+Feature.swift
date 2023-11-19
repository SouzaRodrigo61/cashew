//
//  TaskDetails+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import Foundation

extension Note {
    struct Feature: Reducer {
        struct State: Equatable {
            var note: Note.Model = .init(author: "", item: [])
            
            var item: IdentifiedArrayOf<NoteItem.Feature.State> = []
        }
        
        enum Action: Equatable {
            case item(NoteItem.Feature.State.ID, NoteItem.Feature.Action)
            
            case onAppear
            case closeTapped
            case addBlock
            
            case saveNote(Task.Model)
        }
        
        @Dependency(\.dismiss) var dismiss
        
        var body: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                case .onAppear:
                    
                    return .none
                case .closeTapped:
                    return .run { send in
                        await dismiss()
                    }
                case .addBlock:
                    
                    if let lastItem = state.note.item.last {
                        if lastItem.block.type == .text, let text = lastItem.block.text, text.text.isEmpty {
                            
                            return .none
                        }
                    }
                    
                    
                    let count = state.note.item.count
                    
                    let content: Note.Model.Item.Block = .init(type: .text, text: .init(size: .body, fontWeight: .normal, text: ""), background: .normal, isMarked: false, alignment: .leading)
                    
                    state.note.item.append(.init(block: content))
                    
                    guard let value = content.text else { return .none }
                    
                    state.item.append(.init(id: content.id, text: .init(content: .init(id: value.id, size: value.size, fontWeight: value.fontWeight, text: value.text))))
                    
                    return .none
                    
                case .item(_, .text(.updatedContent(let newContent))):

                    return .none
                
                case .item(_, .text(.removeLine)):
              
                    return .none
                    
                case .item(_, .text(.nextLine)):
                    
                    return .send(.addBlock)
                default:
                    return .none
                }
            }
            .forEach(\.item, action: /Action.item) {
                NoteItem.Feature()
            }
        }
    }
}
