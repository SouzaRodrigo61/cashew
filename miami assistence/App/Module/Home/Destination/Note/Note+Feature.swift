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
            var task: Task.Model
            
            var item: IdentifiedArrayOf<NoteItem.Feature.State> = []
            
            init(task: Task.Model) {
                self.task = task
                
                task.note.item.forEach {
                    if $0.block.type == .text, let content = $0.block.text {
                        item.append(.init(id: $0.block.id, text: .init(content: content)))
                    }
                    
                    if $0.block.type == .image, let content = $0.block.asset {
                        item.append(.init(id: $0.block.id, asset: .init(content: content)))
                    }
                    
                    if $0.block.type == .separator, let content = $0.block.line {
                        item.append(.init(id: $0.block.id, divider: .init(content: content)))
                    }
                }
            }
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
                    let count = state.task.note.item.count
                    
                    let content: Note.Model.Item.Block = .init(type: .text, text: .init(size: .body, fontWeight: .normal, text: ""), background: .normal, isMarked: false, alignment: .leading)
                    
                    state.task.note.item.append(.init(position: count + 1, block: content))
                    
                    guard let value = content.text else { return .none }
                    
                    state.item.append(.init(id: content.id, text: .init(content: .init(id: value.id, size: value.size, fontWeight: value.fontWeight, text: value.text))))
                    
                    return .none
                    
                case .item(let id, .text(.updatedContent(let newContent))):
                    let content = state.task.note.item.first { $0.block.id == id }
                    let index = state.task.note.item.firstIndex { $0.block.id == id }
                    guard var value = content else { return .none }
                    guard var valueIndex = index else { return .none }
                    value.block.text = newContent
                    
                    state.task.note.item.remove(at: valueIndex)
                    state.task.note.item.insert(value, at: valueIndex)
                    
                    return .send(.saveNote(state.task))
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
