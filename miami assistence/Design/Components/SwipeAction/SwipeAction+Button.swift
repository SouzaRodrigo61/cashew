//
//  SwipeAction+Button.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 01/09/23.
//

import SwiftUI

extension SwipeAction {
    struct Button: SwiftUI.View, Identifiable {
        static let width: CGFloat = 70
        
        let id = UUID()
        let text: Text?
        let icon: Image?
        let action: () -> Void
        let tint: Color?
        
        init(text: Text? = nil,
             icon: Image? = nil,
             action: @escaping () -> Void,
             tint: Color? = nil) {
            self.text = text
            self.icon = icon
            self.action = action
            self.tint = tint ?? .gray
        }
        
        var body: some SwiftUI.View {
            ZStack {
                tint
                VStack {
                    icon?
                        .foregroundColor(.white)
                    if icon == nil {
                        text?
                            .foregroundColor(.white)
                    }
                }
                .frame(width: Button.width)
            }
        }
    }
}
