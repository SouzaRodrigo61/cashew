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
        let path: StoreOf<Destination>
        
        var body: some SwiftUI.View {
            Form {
                Text(
                      """
                      This screen demonstrates a basic feature hosted in a navigation stack.
                      
                      You can also have the child feature dismiss itself, which will communicate back to the \
                      root stack view to pop the feature off the stack.
                      """
                )
                
                Section {
                    Button("Voltar") {
                        withAnimation {
                            path.send(.dismissButtonTapped)
                        }
                    }
                }
                
                Button("Go to Login Flow") {
                    withAnimation {
                        path.send(.moveToLoginFlow)
                    }

                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
