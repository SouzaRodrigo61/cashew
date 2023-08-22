//
//  View+Extensions.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/06/23.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func offset(coordinateSpace: String, offset: @escaping (CGFloat) -> ()) -> some View {
        self.overlay {
            GeometryReader { geo in
                let minY = geo.frame(in: .named(coordinateSpace)).minY
                
                Color.clear
                    .preference(key: ValueKey.self, value: minY)
                    .onPreferenceChange(ValueKey.self) { offset($0) }
            }
        }
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

struct ValueKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
