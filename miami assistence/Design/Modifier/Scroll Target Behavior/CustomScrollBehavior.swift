//
//  CustomScrollBehavior.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 21/11/23.
//

import SwiftUI

/// Custom Scroll Behavior
struct CustomScrollBehavior: ScrollTargetBehavior {
    var maxHeight: CGFloat
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < maxHeight {
            target.rect = .zero
        }
    }
    
    
}
