//
//  Tag+Model.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 05/09/23.
//

import Foundation

extension Tag {
    struct Model: Equatable, Identifiable, Codable {
        var id = UUID()
        var value: String
    }
}
