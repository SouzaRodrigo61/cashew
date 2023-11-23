//
//  Task+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import SwiftUI

extension Task {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        @State var offset: CGFloat = .nan
        
        @State private var axisY: CGFloat = .nan
        
        var body: some SwiftUI.View {
            IfLetStore(store.scope(state: \.isEmpty, action: Feature.Action.isEmpty)) {
                Empty.View(store: $0)
                    .padding(.horizontal, 8)
            } else: {
                VStack(alignment: .leading, spacing: 0) {
                    Text("task.header.title")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                        
                    
                    ForEachStore(store.scope(state: \.item, action: Feature.Action.item)) {
                        TaskItem.View(store: $0)
                    }
                }
            }
        }
        
    }
}
