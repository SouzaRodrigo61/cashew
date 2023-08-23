//
//  Create Type Company+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension CreateTypeCompany {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            Form {
                Text(
                      """
                      This screen demonstrates a basic feature hosted in a navigation stack.
                      
                      You can also have the child feature dismiss itself, which will communicate back to the \
                      root stack view to pop the feature off the stack.
                      """
                )
                
                Button("Voltar") {
                    store.send(.dismissTapped, transaction: .init(animation: .bouncy))
                }
                
                Button("Continuar") {
                    store.send(.buttonTapped, transaction: .init(animation: .bouncy))
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
