//
//  URL+Extension.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/09/23.
//

import Foundation

extension URL {
    static let tasks = Self.documentsDirectory.appending(component: "tasks.json")
}
