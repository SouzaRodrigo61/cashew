//
//  TabContainer.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 02/07/23.
//

import SwiftUI

struct TabContainer: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String)] = [
        ("house", "Home"),
        ("magnifyingglass", "Search"),
        ("heart", "Favorites"),
        ("magnifyingglass", "Search"),
        ("house", "Home"),
    ]
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                let source: Bool = (index + 1 == tabSelection)
                
                Button {
                    withAnimation {
                        tabSelection = index + 1
                    }
                } label: {
                        VStack {
                            Image(systemName: tabBarItems[index].image)
                                .font(.system(size: source ? 20 : 14))
                        }
                        .padding(16)
                        .frame(width: 68, height: 60)
                        .background {
                            if source {
                                RoundedRectangle(cornerRadius: 36, style: .continuous)
                                    .foregroundStyle(.miamiTabBarSelectedBackground)
                                    .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                            }
                        }
                        .foregroundStyle(source ? .miamiTabBarSelectedIcon  : .miamiGray)
                    }
            }
        }
        .padding(2)
        .background {
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .foregroundStyle(.white.opacity(0.9))
                .shadow(color: .miamiBlack.opacity(0.2), radius: 20)
        }
        .padding(.bottom, 20)
    }
}
