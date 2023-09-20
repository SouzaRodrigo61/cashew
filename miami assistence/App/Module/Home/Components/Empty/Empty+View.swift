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
            
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.shield.fill")
                    .font(.system(.title, design: .rounded))
                    .foregroundStyle(.royalBlue)
                WithViewStore(store, observe: \.currentDate) { viewStore in
                    Text("task.empty.label.content".localized(args: viewStore.state.dayNum()))
                        .foregroundStyle(.dark)
                        .font(.system(.title3, design: .rounded))
                }
            }
            .padding(.horizontal, 8)
        }
    }
}
