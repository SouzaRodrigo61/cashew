//
//  Calendar+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 04/09/23.
//

import SwiftUI
import ComposableArchitecture

extension Schedule {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            VStack {
                Text("Schedule")
            }
        }
    }
}
