//
//  HomeView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/06/23.
//

import SwiftUI

struct HomeView: View {
    @State private var isNavBarHidden = false
    
    let safeArea: EdgeInsets
    let size: CGSize
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                StickyHeader()
                
                VStack {
                    Text("Hello")
                        .foregroundStyle(.miamiDarkGrayOne)
                }
                .cardModifier(padding: 16.0, height: 300, width: size.width)
                
                
                VStack {
                    Text("Hello")
                        .foregroundStyle(.miamiDarkGrayOne)
                }
                .cardModifier(padding: 16.0, height: 80, width: size.width)
                
                
                VStack {
                    Text("Hello")
                        .foregroundStyle(.miamiDarkGrayOne)
                }
                .cardModifier(padding: 16.0, height: 100, width: size.width)
                
                VStack {
                    Text("Hello")
                        .foregroundStyle(.miamiDarkGrayOne)
                }
                .cardModifier(padding: 16.0, height: 300, width: size.width)
                
                StickyFooter()
            }
        }
        .coordinateSpace(name: "SCROLL")
        .background(.miamiBlack)
    }
    
    
    @ViewBuilder
    func StickyHeader() -> some View {
        let height = size.height * 0.42
        let opacityByHeight = height - 90
        
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            
            VStack {
                Text("\(minY)")
                    .font(.title)
                    .foregroundStyle(.miamiDarkGrayOne)
            }
            .cardModifier(padding: 16.0,
                          height: size.height + ( minY > 0 ? minY : 0),
                          width: size.width,
                          alignment: .bottomLeading,
                          corners: [.bottomLeft, .bottomRight])
            .clipped()
            .offset(y: -minY)
            .opacity(minY >= -opacityByHeight ? 1 : 0)
            .animation(.easeInOut(duration: 0.25), value: minY >= -opacityByHeight)
                
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func StickyFooter() -> some View {
        let height = size.height * 0.05
        
        GeometryReader { proxy in
            VStack {
                Spacer().frame(height: 8)
                Text("Version: 1.0.0")
                    .font(.caption)
                    .foregroundStyle(.miamiDarkGrayOne)
            }
            .padding(.horizontal, 16)
            .cardModifier(padding: 0,
                          height: size.height,
                          width: size.width,
                          color: .clear,
                          alignment: .top)
            .clipped()
        }
        .frame(height: height + safeArea.bottom)
    }
}

#Preview {
    GeometryReader {
        let safeArea = $0.safeAreaInsets
        let size = $0.size
        
        HomeView(safeArea: safeArea, size: size)
            .ignoresSafeArea(.container, edges: .top)
    }
}
