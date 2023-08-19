//
//  ButtonStyle+Extensions.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 18/08/23.
//

import SwiftUI

extension ButtonStyle where Self == ButtonDesign.ScaleButtonStyle {
    static var scale: ButtonDesign.ScaleButtonStyle {
        ButtonDesign.ScaleButtonStyle()
    }
}

extension ButtonStyle where Self == ButtonDesign.PressBorderedButtonStyle {
    static var pressBordered: ButtonDesign.PressBorderedButtonStyle {
        ButtonDesign.PressBorderedButtonStyle()
    }
}
