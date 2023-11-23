//
//  HeaderGoalProgress+View.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 11/11/23.
//

import ComposableArchitecture
import SwiftUI

extension HeaderGoalProgress {
    struct View: SwiftUI.View {
        let store: StoreOf<Feature>
        
        var body: some SwiftUI.View {
            ZStack {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Goal Progress")
                        Text("Good")
                        
                        Spacer()
                        
                        Text("See Details")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("Goal Progress")
                        Text("Adhencekel")
                        
                        Spacer()
                    }
                }
                .padding(16)
                .foregroundStyle(.white)
            }
            .background(Color.gunmetal, in: .rect(cornerRadius: 12))
        }
        
    }
}
