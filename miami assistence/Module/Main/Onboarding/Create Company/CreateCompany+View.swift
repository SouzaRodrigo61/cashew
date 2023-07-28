//
//  Create Company+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension CreateCompany {
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
                
                Section {
                    
                    
                    Button("Voltar") {
//                        withAnimation {
//                            path.send(.dismissButtonTapped)
//                        }
                    }
                }
                
                
                Button("Continuar") {
//                    withAnimation {
//                        path.send(.moveToCreateTypeCompany)
//                    }
                }
            }
//            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
