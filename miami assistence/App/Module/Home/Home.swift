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
        .init(
            taskCalendar: .init(
                task: .init(),
                info: .init(), // TODO: Load company analitycs
                inspiration: .init() // TODO: Load company helps and inspirations
            ),
            destination: StackState([])
        )
    }
}
