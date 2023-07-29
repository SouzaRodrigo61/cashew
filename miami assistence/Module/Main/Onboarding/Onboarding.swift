//
//  Onboarding.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture
import Foundation

enum Onboarding {}

extension Onboarding.Feature.State {
    static func new() -> Self {
        .init(path: StackState([]))
    }
}
