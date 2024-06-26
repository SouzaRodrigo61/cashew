//
//  NoteItem+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/09/23.
//

import ComposableArchitecture
import SwiftUI

extension NoteItem {
    struct View: SwiftUI.View {
        var store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            VStack {
                IfLetStore(store.scope(state: \.text, action: \.text)) {
                    NoteText.View(store: $0)
                }
                IfLetStore(store.scope(state: \.asset, action: \.asset)) {
                    NoteAsset.View(store: $0)
                }
                IfLetStore(store.scope(state: \.divider, action: \.divider)) {
                    NoteDivider.View(store: $0)
                }
            }
            .padding(.bottom, 8)
        }
    }
}
