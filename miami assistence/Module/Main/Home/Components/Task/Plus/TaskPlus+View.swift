//
//  TaskPlus+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/08/23.
//

import ComposableArchitecture
import SwiftUI

extension TaskPlus {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack {
                    Circle()
                        .stroke(
                            Color.pink.opacity(0.5),
                            lineWidth: 8
                        )
                    Circle()
                        .trim(from: 0, to: CGFloat(viewStore.progress)/CGFloat(50))
                        .stroke(
                            Color.pink,
                            style: StrokeStyle(
                                lineWidth: 8,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.smooth, value: viewStore.progress)

                }
                .frame(width: 44, height: 44)
            }
        }
    }
    
}
