//
//  Task+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import Foundation
import SwiftUI

extension Task {
    struct Model: Identifiable, Equatable, Codable {
        
        var id = UUID()
        var title: String
        var date: Date
        var startedHour: Date
        var duration: TimeInterval
        var color: Color
        var isAlert: Bool
        var isRepeted: Bool
        
        var position: Int
        
        var createdAt: Date
        var updatedAt: Date
        
        var tag: [Tag.Model]
        var note: [Note.Model]
    }
    
}
