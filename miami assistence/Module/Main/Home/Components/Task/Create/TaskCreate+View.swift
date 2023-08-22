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
        
        var body: some SwiftUI.View {
            
            Text(
                  """
                  This screen demonstrates a basic feature hosted in a navigation stack.
                  """
            )
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
