//
//  TaskEmpty+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 03/09/23.
//

import SwiftUI
import ComposableArchitecture

extension Empty {
    struct View: SwiftUI.View {
        var store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            VStack(alignment: .center, spacing: 12) {
                Image(systemName: "shippingbox.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.grey500)
                
                Text("task.empty.label.title")
                    .foregroundStyle(.grey900)
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.heavy)
                
                WithViewStore(store, observe: \.currentDate) { viewStore in
                    Text("task.empty.label.content".localized(args: viewStore.state.week()))
                        .foregroundStyle(.grey800)
                        .font(.system(.caption2, design: .rounded))
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .padding(.horizontal, 60)
                }
                
                WithViewStore(store, observe: \.showButton) { viewStore in
                    Button {
                        store.send(.buttonTapped, animation: .smooth)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "plus")
                                .foregroundStyle(.grey900)
                                .font(.system(size: 8, design: .monospaced))
                                .fontWeight(.heavy)
                            
                            Text("task.empty.button.label")
                                .foregroundStyle(.grey900)
                                .font(.system(size: 10, design: .monospaced))
                                .fontWeight(.heavy)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(lineWidth: 1)
                                .fill(.grey400)
                                .background(.grey200, in: .rect(cornerRadius: 4))
                        )
                    }
                    .buttonStyle(.scale)
                }
                
            }
            .hSpacing(.center)
            .padding(.vertical, 24)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .fill(.grey300)
                    .background(.grey100, in: .rect(cornerRadius: 8))
            )
        }
    }
}
