//
//  Main.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

enum Main {
    static func dev() -> View {
        View(path: .init(initialState: .init(path: .onboarding), reducer: Destination()))
    }
}
