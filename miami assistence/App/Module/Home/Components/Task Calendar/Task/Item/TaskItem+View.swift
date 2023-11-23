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
            WithViewStore(store, observe: \.task) { task in
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 0) {
                        Image(systemName: "book.pages.fill")
                            .font(.title3)
                            .symbolRenderingMode(.hierarchical)
                            .frame(width: 50)
                        
                        HStack {
                            Text(task.startedHour)
                                .fontWeight(.heavy)
                                .foregroundStyle(.grey500)
                            
                            Image(systemName: "minus")
                                .font(.title3.bold())
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.grey300)
                            
                            Text(task.startedHour.calculateHourByValue(with: Int(task.duration)))
                                .fontWeight(.heavy)
                                .foregroundStyle(.grey500)
                        }
                        .accessibilityLabel("task.item.accessibility.hour.label")
                        .font(.callout)
                    }
                    .foregroundStyle(.cute500)
                    .hSpacing(.leading)
                    
                    HStack(spacing: 0) {
                        HStack(alignment: .center) {
                            DottedLine()
                                .stroke(.grey300, style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [0,10]))
                                .frame(maxHeight: .infinity)
                                .frame(width: 4)
                        }
                        .frame(width: 50, alignment: .center)
                        
                        SwipeAction.View(cornerRadius: 12, direction: .trailing) {
                            VStack {
                                Text(task.title)
                                    .accessibilityLabel("task.item.accessibility.text.label")
                                    .accessibilityHint("task.item.accessibility.text.hint \(task.title)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.grey900)
                            }
                            .frame(minHeight: 30)
                            .padding(16)
                            .hSpacing(.leading)
                            .background(.grey200)
                            
                        } actions: {
                            SwipeAction.Action(tint: .red, icon: "trash.fill") {
                                DispatchQueue.main.async {
                                    task.send(.deleteTask(task.state), animation: .snappy)
                                }
                            }
                        }
                        .padding(.trailing, 8)

                    }
                    .hSpacing(.leading)
                }
                .id(task.id)
                .hSpacing(.leading)
                .padding(.vertical, 4)
                .onTapGesture {
                    store.send(.contentTapped(task.state))
                }
            }
        }
    }
}

struct DottedLine: Shape {
        
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}
