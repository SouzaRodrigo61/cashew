//
//  ImpactFeedbackGenerator+Extensions.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 24/08/23.
//

import SwiftUI

extension UIImpactFeedbackGenerator {
    static func feedback(_ feedback: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedback).impactOccurred()
    }
}
