//
//  Onboarding+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Onboarding {
    
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            VStack {
                Text(
                      """
                      This screen demonstrates a basic feature hosted in a navigation stack.
                      
                      You can also have the child feature dismiss itself, which will communicate back to the \
                      root stack view to pop the feature off the stack.
                      """
                )
                .padding(.horizontal)
                Spacer()
                
                Button {
                    store.send(.buttonTapped, animation: .bouncy)
                } label : {
                    HStack {
                        Image(systemName: "star")
                        Text("Star system name")
                    }
                }
                .foregroundStyle(.miamiWhite)
                .padding()
                .background(.miamiBlack, in: .rect(cornerRadius: 16))
            }
//            .toolbar(.hidden, for: .navigationBar)
            
        }
    }
}
