//
//  Sticky.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 11/11/23.
//

import SwiftUI

struct Sticky: ViewModifier {
    var stickyRects: [CGRect]
    @State private var frame: CGRect = .zero

    var isSticking: Bool {
        frame.minY < 0
    }
    
    var offset: CGFloat {
        guard isSticking else { return 0 }
        var o = -frame.minY
        if let idx = stickyRects.firstIndex(where: { $0.minY > frame.minY && $0.minY < frame.height }) {
            let other = stickyRects[idx]
            o -= frame.height - other.minY
        }
        return o
    }

    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .zIndex(isSticking ? .infinity : 0)
            .overlay(GeometryReader { proxy in
                let f = proxy.frame(in: .named("container"))
                Color.clear
                    .onAppear { frame = f }
                    .onChange(of: f) { frame = $0 }
                    .preference(key: FramePreference.self, value: [frame])
            })
    }
}
