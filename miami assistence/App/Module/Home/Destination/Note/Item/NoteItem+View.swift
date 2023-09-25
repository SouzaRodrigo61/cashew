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
                IfLetStore(store.scope(state: \.text, action: Feature.Action.text)) {
                    NoteText.View(store: $0)
                }
                IfLetStore(store.scope(state: \.asset, action: Feature.Action.asset)) {
                    NoteAsset.View(store: $0)
                }
                IfLetStore(store.scope(state: \.divider, action: Feature.Action.divider)) {
                    NoteDivider.View(store: $0)
                }
            }
        }
    }
}
