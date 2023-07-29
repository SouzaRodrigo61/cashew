//
//  Main.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

enum Main {
    static func home() -> View {
        View(store: .init(initialState: .init(home: .new()), reducer: Feature()))
    }
    
    static func dev() -> View {
        View(store: .init(initialState: .init(onboarding: .new(), home: .new()), reducer: Feature()))
    }
    
    static func onboarding() -> View {
        View(store: .init(initialState: .init(onboarding: .new()), reducer: Feature()))
    }
}
