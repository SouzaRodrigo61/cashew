//
//  OffsetPreferenceKey.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/06/23.
//

import SwiftUI

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

struct OffsetPreferenceView: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: OffsetPreferenceKey.self, value: geometry.frame(in: .global).origin)
        }
        .frame(width: 0, height: 0)
        .clipped()
    }
}
