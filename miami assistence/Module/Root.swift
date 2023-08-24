//
//  Main.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

enum Root {
    static func build() -> View {
        View(store: Feature.store)
    }
}

extension Root.Feature {
    static let store = Store(initialState: Self.State.build()) { Self() }
}

extension Root.Feature.State {
    static func build() -> Self {
        .onboarding(.new())
    }
}
