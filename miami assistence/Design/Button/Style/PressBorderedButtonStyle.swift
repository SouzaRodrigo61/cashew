//
//  Button.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import SwiftUI

extension ButtonDesign {
    struct PressBorderedButtonStyle: ButtonStyle {
        public init() {}
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding(6)
                .background(configuration.isPressed ? .gray.opacity(0.2) : .clear, in: .rect(cornerRadius: 8))
        }
    }
}
