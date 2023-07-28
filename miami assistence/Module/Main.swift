//
//  Main.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

enum Main {
    static func dev() -> View {
        View(store: .init(
            initialState: .init(path: StackState([.onboarding(Onboarding.Feature.State())])),
            reducer: Feature()
        ))
    }
}
