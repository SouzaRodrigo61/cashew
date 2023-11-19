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
                HStack {
                    VStack {
                        Text("Goal Progress")
                        Text("Good")
                        
                        Spacer()
                        
                        Text("See Details")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Goal Progress")
                        Text("Adhencekel")
                        
                        Spacer()
                    }
                }
//                .padding(16)
                .frame(height: 200)
                .foregroundStyle(.white)
            }
            .background(Color.gunmetal, in: .rect(cornerRadius: 12))
        }
        
    }
}
