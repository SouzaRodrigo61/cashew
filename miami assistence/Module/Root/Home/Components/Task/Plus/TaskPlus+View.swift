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
                
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.pink.opacity(0.8))
                        .padding(1.5)
                        .background {
                            Circle()
                                .stroke(
                                    Color.pink.opacity(0.5),
                                    lineWidth: 4
                                )
                                .overlay {
                                    Circle()
                                        .trim(from: 0, to: viewStore.progress)
                                        .stroke(
                                            Color.pink,
                                            style: StrokeStyle(
                                                lineWidth: 4,
                                                lineCap: .round
                                            )
                                        )
                                        .rotationEffect(.degrees(-90))
                                }
                        }
                        .frame(width: 35, height: 35, alignment: .bottom)
                }
                
            }
        }
    }
    
}
