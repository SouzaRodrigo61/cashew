//
//  View+Extensions.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/06/23.
//

import SwiftUI

/// Custom View Extensions
extension View {
    
    /// Custom Spacer
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    /// Custom Spacer
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    /// Checking Two Dates are same
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
