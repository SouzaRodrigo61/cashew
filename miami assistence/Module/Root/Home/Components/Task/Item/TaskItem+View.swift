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
        
        @State private var isChecked = false
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                Button {
                    store.send(.sendToDetail(viewStore.task))
                } label: {
                    taskItem(viewStore.task)
                        .hSpacing(.leading)
                }
                .padding(.horizontal, 16)
                .padding(8)
                .frame(minHeight: 64)
                .background(.white, in: .rect(cornerRadius: 10))
                .contentShape(.dragPreview, .rect(cornerRadius: 10))
                .overlay {
                    if let draggingTaskId = viewStore.draggingTaskId, draggingTaskId == viewStore.task.id, viewStore.isDragging {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(.cornFlower, lineWidth: 2)
                            
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lotion, lineWidth: 2)
                    }
                }
                .padding(.horizontal, 16)
                .draggable(viewStore.task.id.uuidString) {
                    Text(viewStore.task.title)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .frame(width: 200, alignment: .leading)
                        .foregroundStyle(.dark)
                        .background(.white, in: .rect(cornerRadius: 10))
                        .contentShape(.dragPreview, .rect(cornerRadius: 10))
                        .onAppear {
                            store.send(.currentlyDragging(viewStore.task), animation: .linear)
                        }
                }
                .dropDestination(for: String.self) { items, location in
                    store.send(.removeCurrentlyDragging, animation: .linear)
                    return true
                } isTargeted: { status in
                    if status {
                        store.send(.dragged(viewStore.task), animation: .linear)
                    } else {
                        store.send(.removeDragging, animation: .linear)
                    }
                }
            }
        }
        
        
        @ViewBuilder
        private func taskItem(_ task: Task.Model) -> some SwiftUI.View {
            // TODO: Create UI for this component
            
            HStack(alignment: .center) {
                Image(systemName: "minus")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.dark)
                    .padding(.trailing, 8)
 
//                Toggle(isOn: $isChecked) { }
//                    .toggleStyle(.checkmark)
//                    .foregroundStyle(.dark)
                
                Text(task.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.dark)
                    .padding(.leading, 8)
            }
            .hSpacing(.leading)
        }
    }
}
