//
//  TaskDetails+Feature.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import Foundation

extension Note {
    @Reducer
    struct Feature {
        struct State: Equatable {
            var note: Note.Model = .init(author: "", item: [])
            
            var item: IdentifiedArrayOf<NoteItem.Feature.State> = []
        }
        
        @CasePathable
        enum Action: Equatable {
            case item(IdentifiedActionOf<NoteItem.Feature>)
            
            case onAppear
            case closeTapped
            case addBlock
            
            case saveNote(Task.Model)
        }
        
        @Dependency(\.dismiss) var dismiss
        
        var body: some Reducer<State, Action> {
            Reduce(self.core)
                .forEach(\.item, action: \.item) {
                    NoteItem.Feature()
                }
        }
        
        
        private func core(into state: inout State, action: Action) -> Effect<Action> {
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
                
                
//                let count = state.note.item.count
                
                let content: Note.Model.Item.Block = .init(type: .text, text: .init(size: .body, fontWeight: .normal, text: ""), background: .normal, isMarked: false, alignment: .leading)
                
                state.note.item.append(.init(block: content))
                
                guard let value = content.text else { return .none }
                
                state.item.append(.init(id: content.id, text: .init(content: .init(id: value.id, size: value.size, fontWeight: value.fontWeight, text: value.text))))
                
                return .none
                
            case .item(.element(id: _, action: .text(.updatedContent(_)))):
                return .none
                
            case .item(.element(id: _, action: .text(.removeLine))):
                
                return .none
                
            case .item(.element(id: _, action: .text(.nextLine))):
                
                return .send(.addBlock)
            default:
                return .none
            }
        }
    }
}
