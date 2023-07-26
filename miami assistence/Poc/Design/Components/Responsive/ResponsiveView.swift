//
//  ResponsiveView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 29/06/23.
//

import SwiftUI

struct Properties {
    var isLandscape: Bool
    var isiPad: Bool
    var size: CGSize
    var safeArea: EdgeInsets
}

struct ResponsiveView<Content: View>: View {
    let content: (Properties) -> Content
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            let isLandscape = ( size.width > size.height)
            let isiPad = UIDevice.current.userInterfaceIdiom == .pad
            let prop = Properties(isLandscape: isLandscape, isiPad: isiPad, size: size, safeArea: safeArea)
            
            content(prop)
                .frame(width: size.width, height: size.height, alignment: .center)
        }
    }
}
