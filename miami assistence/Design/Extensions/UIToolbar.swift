//
//  UIToolbar.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 06/09/23.
//

import SwiftUI

extension UIToolbar {
    static func changeAppearance(clear: Bool) {
        let appearance = UIToolbarAppearance()
        
        if clear {
            appearance.configureWithOpaqueBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }

        // customize appearance for your needs here
        appearance.shadowColor = .clear
//         appearance.backgroundColor = .clear
        appearance.backgroundImage = UIImage(named: "imageName")
        
        UIToolbar.appearance().standardAppearance = appearance
        UIToolbar.appearance().compactAppearance = appearance
        UIToolbar.appearance().scrollEdgeAppearance = appearance
    }
}
