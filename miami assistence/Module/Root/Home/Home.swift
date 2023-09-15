//
//  Home.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

enum Home {}

extension Home.Feature.State {
    static func new() -> Self {
        .init(task: .init(),
              header: .init(today: .init()),
              bottomSheet: .init(),
              tabCalendar: .init(),
              destination: StackState([]))
    }
}
