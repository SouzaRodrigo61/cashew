//
//  TaskItem+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import SwiftUI
import Foundation

extension TaskItem {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        @State var disableAnimation: Bool = true
        @State var offset: CGFloat = .zero
        @State var proxyOffset: CGPoint = .zero
        @State var colorRectangle: Color = .lotion
        @State var colorView: Color = .clear
        
        var body: some SwiftUI.View {
            GeometryReader { geo in
                WithViewStore(store, observe: \.task) { viewStore in
                    Content(id: viewStore.id, task: viewStore.state, color: colorView)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(.dragPreview, .rect(cornerRadius: 10))
                        .onDrag {
                            store.send(.setCurrentlyDragged(viewStore.state))
                            return NSItemProvider()
                        } preview: {
                            Text(viewStore.title)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 16)
                                .frame(width: 200, alignment: .leading)
                                .foregroundStyle(.dark)
                                .background(.white, in: .rect(cornerRadius: 10))
                                .contentShape(.dragPreview, .rect(cornerRadius: 10))
                        }
                        .onTapGesture {
                            store.send(.contentTapped(viewStore.state))
                        }
                }
            }
            .frame(height: 80)
        }
        
        @ViewBuilder
        private func content(
            id: UUID,
            task: Task.Model
        ) -> some SwiftUI.View {

        }
    }
}
