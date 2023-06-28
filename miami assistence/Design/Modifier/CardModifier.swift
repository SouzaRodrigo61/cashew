//
//  CardModifier.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/06/23.
//

import SwiftUI

struct CardModifier: ViewModifier {
    let padding: CGFloat
    let height: CGFloat
    let width: CGFloat
    let color: Color
    let alignment: Alignment
    let corners: UIRectCorner
    
    public func body(content: Content) -> some View {
        content
            .padding(padding)
            .frame(width: width,
                   height: height,
                   alignment: alignment)
            .background(color)
            .cornerRadius(12, corners: corners)
            .shadow(color: .miamiWhite.opacity(0.2), radius: 20)
    }
}
