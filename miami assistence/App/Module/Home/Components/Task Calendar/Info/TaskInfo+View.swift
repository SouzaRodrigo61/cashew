//
//  TaskInfo+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 12/11/23.
//

import ComposableArchitecture
import SwiftUI

extension TaskInfo {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            Text("Task Info")
        }
        
    }
}
