//
//  TaskItem+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import SwiftUI

extension TaskItem {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        let draggedTask: Task.Model?
        let isDragging: Bool
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                Button {
                    store.send(.sendToDetail(viewStore.task))
                } label: {
                    VStack {
                        Text(viewStore.task.title)
                        Text(viewStore.task.date.description)
                        Text(viewStore.task.duration.description)
                    }
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.dark)
                .background(.white, in: .rect(cornerRadius: 10))
                .contentShape(.dragPreview, .rect(cornerRadius: 10))
                .overlay {
                    if let draggedTask = draggedTask, draggedTask.id == viewStore.task.id, isDragging {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.lotion)
                    }
                }
                .draggable(viewStore.task.id.uuidString) {
                    Text(viewStore.task.title)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .frame(width: 200, alignment: .leading)
                        .foregroundStyle(.dark)
                        .background(.white, in: .rect(cornerRadius: 10))
                        .contentShape(.dragPreview, .rect(cornerRadius: 10))
                        .onAppear {
                            store.send(.currentlyDragging(viewStore.task))
                        }
                }
                .dropDestination(for: String.self) { items, location in
                    store.send(.removeCurrentlyDragging)
                    return false
                } isTargeted: { status in
                    if status {
                        store.send(.dragged(viewStore.task), animation: .snappy)
                    }
                }
            }
        }
    }
}
