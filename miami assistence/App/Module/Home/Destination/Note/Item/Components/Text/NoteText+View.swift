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
        
        @FocusState private var focused: Bool
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: { $0 }) { viewStore in
                HStack(spacing: 0) {
                    TextField("", text: viewStore.binding(get: \.content.text, send: Feature.Action.changeText), axis: .vertical)
                        .onChange(of: viewStore.content.text) { oldValue, newValue in
                            var value = newValue
                            dump(value, name: "value")
                            
                            if value.isEmpty {
                                dismissKeyboard()
                                store.send(.removeLine)
                                
                                // setFocusToLastContent
                            }
                            
                            if value.hasSuffix("\n") {
                                dismissKeyboard()
                                
                                value.removeLast()
                                
                                if value.isEmpty {
                                    store.send(.removeLine)
                                    // setFocus to Last content
                                } else {
                                    store.send(.changeText(value))
                                }
                            }
                        }
                        .font(viewStore.content.size == .title
                              ? .title3 : viewStore.content.size == .subTitle
                              ? .subheadline : viewStore.content.size == .heading
                              ? .headline : viewStore.content.size == .caption
                              ? .caption : .body)
                        .fontDesign(.default)
                        .fontWeight(viewStore.content.fontWeight == .bold
                                    ? .bold : viewStore.content.fontWeight == .medium
                                    ? .medium : viewStore.content.fontWeight == .tiny
                                    ? .thin : .regular )
                        .padding(0)
                        .submitLabel(.done)
                        .focused($focused)
                        .onAppear { focused = viewStore.hasFocus }
                        .onChange(of: viewStore.hasFocus) { old, new in
                            print(new)
                        }
                    
                    if focused {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
        }
        
        func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

extension View {
    func synchronize<Value: Equatable>(
        _ first: Binding<Value>,
        _ second: FocusState<Value>.Binding
    ) -> some View {
        self
            .onChange(of: first.wrappedValue) { new, _ in second.wrappedValue = new }
            .onChange(of: second.wrappedValue) { new, _ in first.wrappedValue = new }
    }
}
