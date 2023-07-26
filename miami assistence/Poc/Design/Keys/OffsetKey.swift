//
//  OffsetKey.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 08/07/23.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func  reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
