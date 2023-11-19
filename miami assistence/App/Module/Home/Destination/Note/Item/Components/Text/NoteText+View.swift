//
//  NoteText+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/09/23.
//

import SwiftUI
import ComposableArchitecture

extension NoteText {
    struct View: SwiftUI.View {
        var store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: \.content) { viewStore in
                UITextViewWrapper(text: viewStore.binding(get: \.text, send: Feature.Action.changeText))
            }
        }
    }
}

