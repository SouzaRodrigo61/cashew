//
//  UINavigationBar+Extensions.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/09/23.
//

import SwiftUI

extension UINavigationBar {
    static func changeAppearance(clear: Bool) {
        let appearance = UINavigationBarAppearance()

        // Before
        // appearance.shadowColor = .clear

        if clear {
            appearance.configureWithOpaqueBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }

        // After
        appearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
