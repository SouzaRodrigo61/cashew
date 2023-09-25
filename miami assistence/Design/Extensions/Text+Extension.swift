//
//  Text+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/09/23.
//

import SwiftUI

extension Text {
    func getContrastText(backgroundColor: Color, white color: Color = .white, dark colorDark: Color = .black) -> some View {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        UIColor(backgroundColor).getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  luminance < 0.6 ? self.foregroundStyle(color) : self.foregroundStyle(colorDark)
    }
}


extension View {
    func getContrast(backgroundColor: Color, white color: Color = .white, dark colorDark: Color = .black) -> some View {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        UIColor(backgroundColor).getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  luminance < 0.6 ? self.foregroundStyle(color) : self.foregroundStyle(colorDark)
    }
}


extension Color {
    func getContrast() -> Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  luminance < 0.6 ? true : false
    }
}
