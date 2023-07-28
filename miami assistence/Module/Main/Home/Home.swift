//
//  Home.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 26/07/23.
//

import ComposableArchitecture

enum Home {    
    static func builder(with store: StoreOf<Main.Destination>) -> View {
        View(path: Destination.builder(), mainPath: store)
    }
}
