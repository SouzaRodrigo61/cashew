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
                
                Button("button.back") {
                    store.send(.dismissTapped, transaction: .init(animation: .bouncy))
                }
                
                Button("button.continues") {
                    store.send(.buttonTapped, transaction: .init(animation: .bouncy))
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
