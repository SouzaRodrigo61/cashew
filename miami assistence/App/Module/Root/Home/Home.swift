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
            taskCalendar: .init(
                task: .init(empty: .init(.init(currentDate: currentDate))), 
                header: .init(
                    today: .init(
                        week: Date().validateIsToday(),
                        weekCompleted: Date().week()
                    )
                )
            ), 
            bottomSheet: .init(),
            destination: StackState([])
        )
    }
}
