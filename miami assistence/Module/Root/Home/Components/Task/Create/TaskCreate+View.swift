//
//  Create+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 19/08/23.
//


import ComposableArchitecture
import SwiftUI

extension TaskCreate {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        
        @FocusState private var focusedField: Field?
        @State var username: String = ""
        
        var body: some SwiftUI.View {
            WithViewStore(store, observe: { $0 } ) { viewStore in
                VStack {
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            store.send(.closeTapped, animation: .snappy)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.gray)
                        }
                    }
                    .buttonStyle(.pressBordered)
                    .padding(.top, 8)
                    .padding(.horizontal, 8)
                    
                    
                    VStack {
                        Text("Title: \(viewStore.title)")
                        
                        TextField("Untitled Todo", text: viewStore.$title)
                            .padding(.horizontal, 8)
                            .focused($focusedField, equals: .name)
                    }
                    .vSpacing(.top)
                    
                    Button {
                        store.send(.createTaskTapped, animation: .snappy)
                    } label: {
                        Text("Add Tasking")
                    }
                    .padding(.bottom, 8)
                }
                .onAppear { focusedField = .name }
                .hSpacing(.topLeading)
                .frame(height: 300)
                .background(.white)
            }
        }
    }
}

extension TaskCreate.View {
    private enum Field: Int, Hashable {
        case name
    }
}
