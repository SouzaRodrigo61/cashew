//
//  ScaleButtonStyle.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import SwiftUI

extension ButtonDesign {
    struct ScaleButtonStyle: ButtonStyle {
        public init() {}
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.linear(duration: 0.2), value: configuration.isPressed)
                .brightness(configuration.isPressed ? -0.05 : 0)
        }
    }
}
