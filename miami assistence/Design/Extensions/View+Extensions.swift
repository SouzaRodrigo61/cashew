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
    
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }

    @ViewBuilder
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }

    // MARK: Get SafeArea
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
