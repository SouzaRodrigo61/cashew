//
//  StickerHeader.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/06/23.
//

import SwiftUI

struct StickerHeader<Content: View>: View {
    var content: Content
    
    var minHeight: CGFloat
    
    init(minHeight: CGFloat = 300, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.minHeight = minHeight
    }
    
    var body: some View {
        GeometryReader { geo in
            if geo.frame(in: .global).minY <= 0 {
                content
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
            } else {
                content
                    .offset(y: -geo.frame(in: .global).minY)
                    .frame(width: geo.size.width, height: geo.size.height + geo.frame(in: .global).minY)
            }
        }
        .frame(minHeight: minHeight)
    }
}

