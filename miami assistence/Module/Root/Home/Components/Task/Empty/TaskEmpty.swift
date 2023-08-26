//
//  TaskEmpty.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 24/08/23.
//

import SwiftUI

enum TaskEmpty { }

extension TaskEmpty {
    struct View: SwiftUI.View {
        var body: some SwiftUI.View {
            Text("Show only when doesn't has task itens!")
                .hSpacing(.leading)
                .background(.red)
        
        }
    }
}
