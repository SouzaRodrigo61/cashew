//
//  Search+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/09/23.
//

import ComposableArchitecture
import SwiftUI

extension Search {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            Text("Search")
        }
    }
}
