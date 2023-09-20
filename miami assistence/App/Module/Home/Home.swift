//
//  Home.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import Foundation
import ComposableArchitecture

enum Home {}

extension Home.Feature.State {
    static func new() -> Self {
        let currentDate: Date = Date()
        
        return Self(
            destination: StackState([])
        )
    }
}
