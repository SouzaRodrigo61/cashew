//
//  TaskEmpty+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 03/09/23.
//

import SwiftUI

extension TaskEmpty {
    struct View: SwiftUI.View {
        var body: some SwiftUI.View {
            
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.shield.fill")
                    .font(.system(.title, design: .rounded))
                    .foregroundStyle(.royalBlue)
                Text("task.empty.label.content".localized(args: Date().dayNum()))
                    .foregroundStyle(.dark)
                    .font(.system(.title3, design: .rounded))
            }
            .padding(.horizontal, 8)
        }
    }
}
