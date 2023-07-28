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
//                    withAnimation(.snappy) {
//                        mainPath.send(.path(.onboarding))
//                    }
                }
                Button("Go to Login") {
//                    withAnimation(.snappy) {
//                        mainPath.send(.path(.login))
//                    }
                }
            }
        }
    }
}
