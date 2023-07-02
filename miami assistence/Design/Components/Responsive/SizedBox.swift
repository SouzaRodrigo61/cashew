//
//  SizedBox.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 02/07/23.
//

import SwiftUI

struct SizedBox: View {
    let width: CGFloat
    let height: CGFloat
    let alignment: Alignment
    
    init(width: CGFloat = 0, height: CGFloat = 0, alignment: Alignment = .center) {
        self.width = width
        self.height = height
        self.alignment = alignment
    }
    
    var body: some View {
        Spacer()
            .frame(width: width,
                       height: height,
                       alignment: alignment)
    }
}
