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
            HStack {
                Spacer()
                
                Button {
                    store.send(.addButtonTapped, animation: .bouncy )
                } label: {                    
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                        Text("bottom_sheet.label.create")
                    }
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundColor(.gray)
                }
                .buttonStyle(.pressBordered)
            }
        }
    }
}
