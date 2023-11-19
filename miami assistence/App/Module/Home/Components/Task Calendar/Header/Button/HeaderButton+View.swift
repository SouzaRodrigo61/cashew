//
//  HeaderButton+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 11/11/23.
//

import ComposableArchitecture
import SwiftUI

extension HeaderButton {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            Button {
                store.send(.buttonTapped)
            } label: {
                Image(systemName: "bell.fill")
                    .font(.title3)
                    .foregroundStyle(.royalBlue)
            }
        }
    }
}
