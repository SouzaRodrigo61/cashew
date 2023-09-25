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
            // TODO: Storage image
//            
//        case title
//        case subTitle
//        case heading
//        case body
//        case caption
            
            WithViewStore(store, observe: \.content) { viewStore in
                TextField("", text: viewStore.binding(get: \.text, send: Feature.Action.changeText))
                    .font(viewStore.size == .title
                          ? .title3 : viewStore.size == .subTitle
                          ? .subheadline : viewStore.size == .heading
                          ? .headline : viewStore.size == .caption
                          ? .caption : .body)
                    .fontDesign(.default)
                    .fontWeight(viewStore.fontWeight == .bold
                                ? .bold : viewStore.fontWeight == .medium
                                ? .medium : viewStore.fontWeight == .tiny
                                ? .thin : .regular )
                    
            }
        }
    }
}
