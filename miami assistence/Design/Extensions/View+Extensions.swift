//
//  View+Extensions.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/06/23.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func cardModifier(padding: CGFloat, width: CGFloat, color: Color = .miamiWhite, alignment: Alignment = .topLeading, corners: UIRectCorner = .allCorners) -> some View {
        self
            .modifier(CardModifier(padding: padding, width: width, color: color, alignment: alignment, corners: corners))
    }
    
    @ViewBuilder
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self
            .clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
