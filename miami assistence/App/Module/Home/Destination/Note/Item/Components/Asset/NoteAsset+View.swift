//
//  NoteAsset+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 25/09/23.
//

import SwiftUI
import ComposableArchitecture

extension NoteAsset {
    struct View: SwiftUI.View {
        var store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            // TODO: Storage image
            
            WithViewStore(store, observe: \.content) { viewStore in
                Text(viewStore.asset)
            }
        }
    }
}
