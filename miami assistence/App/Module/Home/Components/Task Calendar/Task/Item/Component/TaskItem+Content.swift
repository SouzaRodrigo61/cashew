//
//  TaskItem+View+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/09/23.
//

import SwiftUI
import ComposableArchitecture

extension TaskItem {
    struct Content: SwiftUI.View {
        let id: UUID
        let task: Task.Model
        let color: Color
        
        let alignment: Alignment
        let showOverlay: Bool
        let forcePadding: Bool
        
        init(
            id: UUID,
            task: Task.Model,
            color: Color,
            alignment: Alignment = .leading,
            showOverlay: Bool = true,
            forcePadding: Bool = false
        ) {
            self.id = id
            self.task = task
            self.color = color
            self.alignment = alignment
            self.showOverlay = showOverlay
            self.forcePadding = forcePadding
        }
        
        var body: some SwiftUI.View {
            VStack {
                HStack {
                    if showOverlay {
                        Text(task.startedHour)
                            .accessibilityLabel("task.item.accessibility.hour.label")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundStyle(.dark)
                            .padding(.leading, 16)
                    }
                                        
                    Text(task.title)
                        .accessibilityLabel("task.item.accessibility.text.label")
                        .accessibilityHint("task.item.accessibility.text.hint \(task.title)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.dark)
                        .padding(.leading, 8)
                        .padding(.leading, forcePadding ? 64 : 0)
                }
                .padding(.vertical, 8)
            }
            .id(id)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .background(
                VStack {
                    if showOverlay {
                        RoundedRectangle(cornerRadius: 9.5)
                            .strokeBorder(color, lineWidth: 2)
                            .background(Color.lotion.shadow(.drop(radius: 7)), in: .rect(cornerRadius: 9.5))
                    }
                }
            )
        }
    }
}
