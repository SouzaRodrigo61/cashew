//
//  Tag+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/09/23.
//

import Foundation

extension Tag {
    struct Model: Identifiable, Equatable {
        var id = UUID()
        var title: String
    }
}
