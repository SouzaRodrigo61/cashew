//
//  Login.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 27/07/23.
//

import ComposableArchitecture

enum Login {
    static func builder(with store: StoreOf<Main.Destination>) -> View {
        View(path: Destination.builder(), mainPath: store)
    }
}
