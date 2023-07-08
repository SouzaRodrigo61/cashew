//
//  Tabbar.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 01/07/23.
//

import SwiftUI

struct TabBar<Content: View>: View {
    @Binding var tabSelection: Int
    let content: Content
    let size: CGSize
        
    init(tabSelection: Binding<Int>, size: CGSize, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._tabSelection = tabSelection
        self.size = size
    }
    
    var body: some View {
        ZStack {
            content
        }
        .frame(width: size.width, height: size.height)
        .background(.miamiWhite)
        .overlay(alignment: .bottom) {
            TabContainer(tabSelection: $tabSelection)
        }
    }
}
