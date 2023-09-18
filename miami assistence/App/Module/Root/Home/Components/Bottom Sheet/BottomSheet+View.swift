//
//  BottomSheet+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import ComposableArchitecture
import SwiftUI

extension BottomSheet {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            Button {
                store.send(.addButtonTapped, animation: .bouncy )
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 40, design: .rounded))
                    .foregroundColor(.royalBlue)
            }
            .buttonStyle(.scale)
            .padding(.trailing, 16)
        }
    }
}
