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
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack(alignment: .leading, spacing: 0) {
                    Text("Onboarding With TCA")
                }
            }
        }
    }
}
