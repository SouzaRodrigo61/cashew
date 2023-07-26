//
//  Onboarding.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import Foundation

enum Onboarding {
    static func dev() -> View {
        View(store: .init(initialState: .init(), reducer: Feature()))
    }
}
