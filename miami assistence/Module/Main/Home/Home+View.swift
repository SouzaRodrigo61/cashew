//
//  Home+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Home {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            VStack {
                Text("Home Stateless")
                
                Button("Go to Onboarding") {
                    store.send(.buttonTapped, transaction: .init(animation: .bouncy))
                }
            }
        }
    }
}
