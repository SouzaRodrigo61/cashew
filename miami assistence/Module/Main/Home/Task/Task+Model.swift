//
//  Task+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import Foundation

extension Task {
    // TODO: Migrate to Corrently Model
    struct Model: Identifiable, Equatable {
        var id = UUID()
        var title: String
        var date: Date
        var duration: TimeInterval
    }
}
