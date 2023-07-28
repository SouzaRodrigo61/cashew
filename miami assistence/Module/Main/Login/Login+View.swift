//
//  Login+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/07/23.
//

import ComposableArchitecture
import SwiftUI

extension Login {
    struct View: SwiftUI.View {
        let path: StoreOf<Destination>
        let mainPath: StoreOf<Main.Destination>
        
        var body: some SwiftUI.View {
            VStack {
                Text("Login Stateless")
                
                Button("Go to Onboarding") {
                    withAnimation(.snappy) {
                        mainPath.send(.path(.onboarding))
                    }
                }
                Button("Go to Home") {
                    withAnimation(.snappy) {
                        mainPath.send(.path(.home))
                    }
                }
            }
        }
    }
}
