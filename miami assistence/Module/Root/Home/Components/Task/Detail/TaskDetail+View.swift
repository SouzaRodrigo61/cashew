//
//  TaskDetails+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 20/08/23.
//

import ComposableArchitecture
import SwiftUI

extension TaskDetail {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            
            Text(
                  """
                  This screen demonstrates a basic feature hosted in a navigation stack.
                  """
            )
//            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
